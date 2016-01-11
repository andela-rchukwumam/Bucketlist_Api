module Api
  class AuthToken
    def self.encode(payload, ttl_in_minutes = 60 * 24 * 30)
      payload[:exp] = ttl_in_minutes.minutes.from_now.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
      begin
        decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)
        decoded[0]
      rescue JWT::ExpiredSignature
      end
    end
  end
end
