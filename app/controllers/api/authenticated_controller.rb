module Api
  class AuthenticatedController < ApiController
    before_action :verify_authorization_header!
    before_action :authenticate_user!

    def current_user
      @current_user ||= get_user_from_auth_token
    end
    
    private

    def authenticate_user!
      raise UnauthorizedError, 'Unauthorized' unless current_user
    end

    def get_user_from_auth_token
      User.find_by(auth_token: request.headers["Authorization"])
    end
  end
end