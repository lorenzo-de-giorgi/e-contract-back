module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_user

      def login
        # Debug logging
        Rails.logger.debug "Raw params: #{params.inspect}"
        
        # Estrai i parametri corretti
        auth_params = if params[:authentication] && params[:authentication][:user]
          params[:authentication][:user]
        else
          login_params  # Use the login_params method to get user data
        end
      
        Rails.logger.debug "Auth params: #{auth_params.inspect}"
        
        email = auth_params[:email]
        password = auth_params[:password]
        
        Rails.logger.debug "Attempting login with email: #{email}"
        
        @user = User.find_by(email: email)
        
        if @user&.authenticate(password)
          token = JwtToken.jwt_encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: {
            token: token,
            exp: time.strftime("%d-%m-%Y %H:%M"),
            username: @user.username
          }, status: :ok
        else
          render json: { 
            error: 'Credenziali non valide',
            debug: {
              email_found: @user.present?,
              params_received: auth_params
            }
          }, status: :unauthorized
        end
      rescue => e
        Rails.logger.error "Login error: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        render json: { error: 'Errore durante il login', details: e.message }, status: :unprocessable_entity
      end

      private

      def login_params
        params.require(:user).permit(:email, :password)
      rescue ActionController::ParameterMissing
        params.permit(:email, :password)
      end
    end
  end
end