# frozen_string_literal: true

module AppStoreConnect
  class Authorization
    AUDIENCE = 'appstoreconnect-v1'

    def initialize(key_id:, issuer_id:, private_key:)
      @key_id = key_id
      @issuer_id = issuer_id
      @private_key = OpenSSL::PKey.read(private_key)
    end

    def payload
      {
        exp: Time.now.to_i + 20 * 60,
        iss: @issuer_id,
        aud: AUDIENCE
      }
    end

    def token
      JWT.encode(payload, @private_key, 'ES256', kid: @key_id)
    end
  end
end