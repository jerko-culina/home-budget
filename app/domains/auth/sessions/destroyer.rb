module Auth
  module Sessions
    class Destroyer
      attr_reader :user
      
      def initialize(user:)
        @user = user
      end

      def destroy
        user.update_columns(auth_token: Auth::Tokens.generate_auth_token)
      end
    end
  end
end