require 'swagger_helper'

RSpec.describe 'API V1 Prompts', type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path '/api/v1/prompts' do
    get 'Interprète un prompt et retourne des données' do
      tags 'Prompts'
      produces 'application/json'

      parameter name: :Authorization, in: :header, type: :string, required: true,
                description: 'Token JWT sous la forme Bearer <token>'

      parameter name: :prompt, in: :query, type: :string, required: true, description: 'Instruction en langage naturel'

      response '200', 'Prompt traité avec succès' do
        let(:Authorization) { "Bearer #{generate_test_token}" } # rubocop:disable RSpec/VariableName
        let(:prompt) { 'List all active users' }

        run_test!
      end

      response '400', 'Prompt manquant' do
        let(:Authorization) { "Bearer #{generate_test_token}" } # rubocop:disable RSpec/VariableName
        let(:prompt) { '' }

        run_test!
      end
    end
  end
end
