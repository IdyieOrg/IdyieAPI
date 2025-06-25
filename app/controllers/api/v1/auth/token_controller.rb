class Api::V1::Auth::TokenController < ApplicationController
  skip_before_action :authorize_request, only: [:exchange]

  SECRET_KEY = Rails.application.credentials.jwt_secret
  SHARED_SECRET = Rails.application.credentials.api_shared_secret

  def exchange
    request_body = request.body.read
    return unauthorized_response unless valid_signature?(request_body)

    data = JSON.parse(request_body)
    payload = { user_id: data['user_id'], email: data['email'], exp: 24.hours.from_now.to_i }
    token = JWT.encode(payload, SECRET_KEY)

    render json: { token: }
  end

  private

  def valid_signature?(request_body)
    received_signature = request.headers['X-Signature']
    expected_signature = OpenSSL::HMAC.hexdigest('SHA256', SHARED_SECRET, request_body)
    ActiveSupport::SecurityUtils.secure_compare(received_signature, expected_signature)
  end

  def unauthorized_response
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
