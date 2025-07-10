require 'swagger_helper'

RSpec.describe 'API V1 Database', type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path '/api/v1/database/schema' do
    get 'Retrieves the database schema' do
      tags 'Database'
      produces 'application/json'

      response '200', 'Schema successfully retrieved' do
        run_test!
      end

      # response '500', 'Error while retrieving the schema' do
      #   # simulate error in your service if needed
      #   run_test!
      # end
    end
  end

  path '/api/v1/database/query' do
    get 'Executes a raw SQL query and returns the results' do
      tags 'Database'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string, required: true,
                description: 'SQL query to execute'

      response '200', 'Query result returned' do
        let(:query) { 'SHOW TABLES' }

        run_test!
      end

      response '400', 'Missing query parameter' do
        let(:query) { '' }

        run_test!
      end

      response '500', 'Error while executing the query' do
        let(:query) { 'SELECT * FROM table_that_does_not_exist' }

        run_test!
      end
    end
  end
end
