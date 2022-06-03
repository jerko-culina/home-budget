module Auth
  module Tokens
    def self.generate_auth_token
      SecureRandom.alphanumeric(60)
    end
  end
end