class Api::V1::DatabaseController < ApplicationController
  def schema
    schema = fetch_schema

    render json: { schema: }, status: :ok
  end

  def query
    query = params[:query]
    data = fetch_local_data(query)

    render json: { data: }, status: :ok
  end

  private

  def fetch_schema
    sqlservice = MysqlConnectionService.new('mariadb', 3306, 'idyie_api_development', 'root', 'password')

    sqlservice.fetch_schema
  end

  def fetch_local_data(query)
    sqlservice = MysqlConnectionService.new('mariadb', 3306, 'idyie_api_development', 'root', 'password')

    sqlservice.fetch_data(query)
  end
end
