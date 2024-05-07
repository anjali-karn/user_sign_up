module Authentication
    def authenticate_user
      # Extract JWT token from Authorization header and split the Bearer
      token = request.headers['Authorization'].split(' ')[1]
  
      begin
        # Decode JWT token and find user based on user ID
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        user_id = decoded_token.first['user_id']
        @current_user = User.find(user_id)
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  end