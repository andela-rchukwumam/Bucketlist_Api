require "jwt"

module Api
  class AuthToken
    SECRET = Rails.application.secrets.secret_key_base

    def self.encode(payload, ttl_in_minutes = 60 * 24 * 30)
      payload[:exp] = ttl_in_minutes.minutes.from_now.to_i
      JWT.encode(payload, SECRET,  'HS512')
    end

    def self.decode(token)
      begin
        decoded = JWT.decode(token, SECRET, true, algorithm: "HS512")
        [true, decoded[0]]
      rescue JWT::ExpiredSignature
        [false, { Error: "This session has expired, please login again" }]
      rescue
        [false, { Error: "Invalid Token, please login again" }]
      end
    end
  end
end
