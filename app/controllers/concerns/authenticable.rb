module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
    attr_reader :current_user_id
  end

  private

  def authorize_request
    token = extract_token_from_header

    if token.nil?
      render_missing_token and return
    end

    decode_and_set_current_user(token)
  end

  def extract_token_from_header
    header = request.headers['Authorization']
    header.split.last if header.present?
  end

  def render_missing_token
    render json: { error: 'Missing token' }, status: :unauthorized
  end

  def decode_and_set_current_user(token)
    decoded = JwtService.decode(token)
    @current_user_id = decoded[:user_id]
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end
end
