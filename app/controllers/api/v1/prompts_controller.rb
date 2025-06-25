class Api::V1::PromptsController < ApplicationController # rubocop:disable Metrics/ClassLength
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

  def get_data(prompt)
    results = transform_prompt_to_query(prompt)
    query = results['sql_query']
    MysqlConnectionService.new(
      host: 'mariadb',
      port: 3306,
      database: 'idyie_api_development',
      username: 'root',
      password: 'password'
    ).fetch_data(query)
  end

  def transform_data(data)
    idyieformatterservice = IdyieFormatterService.new

    response = idyieformatterservice.post('/format', { data: })

    JSON.parse(response.body)['formatted_data']
  end

  def load_data # rubocop:disable Metrics/MethodLength
    case prompt
    when /Fais-moi un bilan comptable sous forme de barre pour le groupe X/i
      {
        data_type: 'barChart',
        content:
        {
          type: 'bar',
          data: {
            labels: ['Compte 1', 'Compte 2'],
            datasets: [
              {
                label: 'Débit',
                data: [200, 50],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
              },
              {
                label: 'Crédit',
                data: [100, 150],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
              }
            ]
          },
          options: {
            scales: {
              y: {
                beginAtZero: true
              }
            }
          }
        }
      }
    when /Fais en sorte que le débit soit en rouge et le crédit en vert/i
      {
        data_type: 'barChart',
        content:
        {
          type: 'bar',
          data: {
            labels: ['Compte 1', 'Compte 2'],
            datasets: [
              {
                label: 'Débit',
                data: [200, 50],
                backgroundColor: 'rgba(255, 99, 96, 0.2)',
                borderColor: 'rgba(255, 99, 96, 1)',
                borderWidth: 1
              },
              {
                label: 'Crédit',
                data: [100, 150],
                backgroundColor: 'rgba(75, 255, 96, 0.2)',
                borderColor: 'rgba(75, 255, 96, 1)',
                borderWidth: 1
              }
            ]
          },
          options: {
            scales: {
              y: {
                beginAtZero: true
              }
            }
          }
        }
      }
    when /Fais-moi un tableau que je pourrais exporter sous différents formats/i
      {
        data_type: 'table',
        content:
        {
          columns: %w[Compte Débit Crédit],
          rows: [
            ['Compte 1', 200, 100],
            ['Compte 2', 50, 150]
          ]
        }
      }
    else
      []
    end
  end
end
