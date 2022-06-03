module Api
  class SessionsController < AuthenitcatedController
    skip_before_action :authenticate_user!, only: [:create]

    def create
      creator = Auth::Sessions::Creator.new(email: params[:email])

      if creator.authenticate_user_with_password(params[:password])
        respond_with creator.user, serializer: AuthenticatedSerializer
      else
        respond_with_errors errors: "Invalid email or password", status: :unprocessable_entity
      end
    end

    def delete
      Auth::Sessions::Destoryer.new(user: current_user).destroy

      head :ok
    end
  end
end
