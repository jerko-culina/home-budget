module Api
  class RegistrationsController < ApiController
    def create
      creator = Auth::Registrations::Creator.new

      if creator.register(register_params)
        respond_with creator.user, serializer: AuthenticatedSerializer, status: :created
      else
        respond_with_errors errors: creator.user.errors.full_messages, status: :unprocessable_entity
      end
    end

    private

    def register_params
      params.require(:user).permit(Auth::Registrations::Creator.permitted_params)
    end
  end
end
