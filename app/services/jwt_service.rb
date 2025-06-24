class JwtService
  SECRET_KEY = Rails.application.credentials.jwt_secret

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature
    raise StandardError, 'Token expired'
  rescue JWT::DecodeError
    raise StandardError, 'Invalid token'
  end
end
