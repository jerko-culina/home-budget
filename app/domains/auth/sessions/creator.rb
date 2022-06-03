module Auth
  module Sessions
    class Creator
      attr_reader :user
      
      def initialize(email:)
        find_user_by_email(email)
      end

      def authenticate_user_with_password(password)
        user&.authenticate(password)
      end

      private

      def find_user_by_email(email)
        @user = User.find_by(email: email)
      end
    end
  end
end