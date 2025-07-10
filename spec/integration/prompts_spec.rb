require 'swagger_helper'

RSpec.describe 'API V1 Prompts', type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path '/api/v1/prompts' do
    get 'Interprets a prompt and returns data' do
      tags 'Prompts'
      produces 'application/json'

      parameter name: :Authorization, in: :header, type: :string, required: true,
                description: 'JWT token in the format Bearer <token>'

      parameter name: :prompt, in: :query, type: :string, required: true, description: 'Instruction in natural language'

      response '200', 'Prompt successfully processed' do
        let(:Authorization) { "Bearer #{generate_test_token}" } # rubocop:disable RSpec/VariableName
        let(:prompt) { 'List all active users' }

        run_test!
      end

      response '400', 'Missing prompt' do
        let(:Authorization) { "Bearer #{generate_test_token}" } # rubocop:disable RSpec/VariableName
        let(:prompt) { '' }

        run_test!
      end
    end
  end
end
