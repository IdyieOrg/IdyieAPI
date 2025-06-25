class Api::V1::DatabaseController < ApplicationController
  before_action :init_mysql_service, only: [:schema, :query]
  skip_before_action :authorize_request, only: [:schema, :query]

  def schema
    schema = @mysql_service.fetch_schema

    if schema
      render json: { schema: }, status: :ok
    else
      render json: { error: 'Failed to fetch schema' }, status: :internal_server_error
    end
  end

  def query # rubocop:disable Metrics/MethodLength
    sql_query = params[:query]

    if sql_query.blank?
      render json: { error: 'No query provided' }, status: :bad_request
      return
    end

    data = @mysql_service.fetch_data(sql_query)

    if data
      render json: { data: }, status: :ok
    else
      render json: { error: 'Failed to execute query' }, status: :internal_server_error
    end
  end

  private

  def init_mysql_service
    @mysql_service = MysqlConnectionService.new(
      host: 'idyie-api-mariadb',
      port: 3306,
      database: 'idyie_api_development',
      username: 'root',
      password: 'password'
    )
  end
end
