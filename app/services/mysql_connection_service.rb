require 'mysql2'

class MysqlConnectionService
  def initialize(host:, port:, database:, username:, password:)
    @host = host
    @port = port
    @database = database
    @username = username
    @password = password
  end

  def fetch_schema # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    schema_data = ''

    with_connection do |client|
      tables = client.query('SHOW TABLES').map { |row| row.values.first }
      tables.reject! { |table| %w[schema_migrations ar_internal_metadata].include?(table) }

      tables.each do |table|
        result = client.query("SHOW CREATE TABLE #{table}").first
        create_table_sql = result.values[1] # second column has CREATE statement
        schema_data += "#{create_table_sql}\n\n"
      end
    end

    Rails.logger.info "Schema data fetched: #{schema_data}"
    schema_data
  rescue StandardError => e
    Rails.logger.error "Error fetching schema: #{e.message}"
    nil
  end

  def fetch_data(query) # rubocop:disable Metrics/MethodLength
    results_data = []
    columns = []

    with_connection do |client|
      results = client.query(query)
      columns = results.fields
      results.each do |row|
        results_data << row
      end
    end

    { columns:, results: results_data }
  rescue StandardError => e
    Rails.logger.error "Error fetching data: #{e.message}"
    nil
  end

  private

  def with_connection
    client = Mysql2::Client.new(
      host: @host,
      port: @port,
      username: @username,
      password: @password,
      database: @database
    )
    yield client
    client.close
  end
end
