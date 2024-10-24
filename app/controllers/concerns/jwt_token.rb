require 'jwt'

module JwtToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.credentials.secret_key_base

  # Il metodo jwt_encode ora richiede il payload come argomento obbligatorio.
  def self.jwt_encode(payload)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Correzione nella funzione jwt_decode: ho rinominato 'decode' in 'decoded'
  def self.jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
