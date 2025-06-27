require 'swagger_helper'

RSpec.describe 'API V1 Database', type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path '/api/v1/database/schema' do
    get 'Récupère le schéma de la base de données' do
      tags 'Database'
      produces 'application/json'

      response '200', 'Schéma récupéré avec succès' do
        run_test!
      end

      # response '500', 'Erreur lors de la récupération du schéma' do
      #   # simulate error in your service if needed
      #   run_test!
      # end
    end
  end

  path '/api/v1/database/query' do
    get 'Exécute une requête SQL brute et retourne les résultats' do
      tags 'Database'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string, required: true,
                description: 'Requête SQL à exécuter'

      response '200', 'Résultat de la requête retourné' do
        let(:query) { 'SHOW TABLES' }

        run_test!
      end

      response '400', 'Paramètre query manquant' do
        let(:query) { '' }

        run_test!
      end

      response '500', 'Erreur lors de l\'exécution de la requête' do
        let(:query) { 'SELECT * FROM table_qui_n_existe_pas' }

        run_test!
      end
    end
  end
end
