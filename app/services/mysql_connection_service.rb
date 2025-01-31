class MysqlConnectionService
  def initialize(host, port, database, username, password)
    @host = host
    @port = port
    @database = database
    @username = username
    @password = password
  end

  def fetch_data(query) # rubocop:disable Metrics/MethodLength
    results = nil
    begin
      Rails.logger.info 'Fetching data'

      # Define connection information
      db_config = {
        adapter: 'mysql2',
        host: @host,
        port: @port,
        database: @database,
        username: @username,
        password: @password
      }

      # Establish connection to the database
      ActiveRecord::Base.establish_connection(db_config)

      # Execute the query
      results = ActiveRecord::Base.connection.execute(query)
      columns = results.fields
    rescue StandardError => e
      Rails.logger.error e.message
    ensure
      ActiveRecord::Base.connection.close
    end

    { columns:, results: }
  end

  def fetch_schema # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    db_config = {
      adapter: 'mysql2',
      host: @host,
      port: @port,
      database: @database,
      username: @username,
      password: @password
    }

    begin
      ActiveRecord::Base.establish_connection(db_config)

      # Get all tables
      tables = ActiveRecord::Base.connection.tables
      tables.reject! { |table| %w[schema_migrations ar_internal_metadata].include?(table) }
      schema_data = ''

      tables.each do |table|
        # Get table creation SQL
        table_info = ActiveRecord::Base.connection.execute("SHOW CREATE TABLE #{table}").first
        create_table_sql = table_info[1]

        # Clean up the SQL to match desired format
        formatted_sql = create_table_sql.split("\n")
                                        .map(&:strip)
                                        .reject(&:empty?)
                                        .join("\n")

        schema_data += "#{formatted_sql}\n\n"
      end
    rescue StandardError => e
      Rails.logger.error e.message
      nil
    ensure
      ActiveRecord::Base.connection.close
    end

    schema_data
  end
end
