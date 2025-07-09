class Api::V1::PromptsController < ApplicationController
  def index # rubocop:disable Metrics/MethodLength
    prompt = params[:prompt]

    if prompt.blank?
      render json: { message: 'Prompt is required', data: [].to_json }, status: :bad_request
      return
    end

    data = get_data(prompt)
    data = transform_data(data)

    render json: {
      message: 'Prompt received',
      data: data.to_json
    }, status: :ok
  end

  private

  def transform_prompt_to_query(prompt)
    idyiellmservice = IdyieLlmService.new

    response = idyiellmservice.post('/get_query', { prompt: })

    JSON.parse(response.body)
  end

  def get_data(prompt) # rubocop:disable Metrics/MethodLength
    results = transform_prompt_to_query(prompt)
    query = results['sql_query']

    unless valid_select_query?(query)
      raise ArgumentError, 'Invalid SQL query: Only SELECT statements are allowed'
    end

    MysqlConnectionService.new(
      host: 'mariadb',
      port: 3306,
      database: 'idyie_api_development',
      username: 'root',
      password: 'password'
    ).fetch_data(query)
  end

  def valid_select_query?(query)
    return false if query.blank?

    normalized_query = query.strip.gsub(/\s+/, ' ').upcase

    return false unless normalized_query.start_with?('SELECT')

    forbidden_keywords = %w[INSERT UPDATE DELETE DROP ALTER TRUNCATE EXECUTE EXEC CALL]
    !forbidden_keywords.any? { |kw| normalized_query.include?(kw) }
  end

  def transform_data(data)
    idyieformatterservice = IdyieFormatterService.new

    response = idyieformatterservice.post('/format', { data: })

    JSON.parse(response.body)['formatted_data']
  end
end
