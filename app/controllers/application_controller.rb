class ApplicationController < ActionController::API
  def decode_token(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    user_id = body['user_id']
    User.find(user_id)
  rescue StandardError
    nil
  end

  def logged_in_user
    token = request.headers['Authorization'].split(' ').last
    @current_user = decode_token(token)
  end

  def authenticate_user
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in_user
  end
end
