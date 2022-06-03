module Api
  class AuthenticatedSerializer < Blueprinter::Base
    field :auth_token
  end
end