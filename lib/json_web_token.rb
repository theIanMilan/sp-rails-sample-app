class JsonWebToken
  JWT_SECRET_KEY = ENV.fetch('JWT_SECRET_KEY')

  def self.encode(payload, exp = 1.day.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, JWT_SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
