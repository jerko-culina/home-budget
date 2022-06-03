module Auth
  module Registrations
    class Creator
      def self.permitted_params
        [:email, :password, :password_confirmation]
      end

      def initialize
        user
      end

      def user 
        @user ||= User.new(auth_token: Auth::Tokens.generate_auth_token)
      end

      def register(params)
        user.assign_attributes(register_params.merge(params))
        user.save
      end

      private

      def register_params
        { 
          email: nil, 
          password: nil, 
          password_confirmation: nil
        }
      end
    end
  end
end