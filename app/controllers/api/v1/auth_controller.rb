module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:email])
    
        if user&.authenticate(params[:password])
          token = encode_token(user.id)
          render json: { token: token }, status: :accepted
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    
      private
    
      def encode_token(user_id)
        JwtToken.jwt_encode({ user_id: user_id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
      end
    end    
  end
end