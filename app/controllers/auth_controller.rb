class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :approve_user]

  def create
   
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      if user.accepted?
        # Encode user ID into a JWT token using a secret key
        token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS256')
        render json: { token: token }
      else
        render json: { error: 'Your account is pending approval. Please wait for admin approval.' }, status: :unauthorized
      end
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def approve_user
    
    admin = Admin.find_by(id: params[:admin_id])

    if admin&.active?
      user = User.find_by(id: params[:user_id])

      if user.present?
        UserMailer.user_approval_notification(user).deliver_now
        user.update(status: :accepted)
        # Proceed with login
        token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS256')
        render json: { token: token }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    else
      render json: { error: 'Only active admins can approve users' }, status: :unauthorized
    end
  end
end
