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
    rescue StandardError => e
      Rails.logger.error e.message
    ensure
      ActiveRecord::Base.connection.close
    end

    results
  end
end
