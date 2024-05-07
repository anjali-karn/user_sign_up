class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
  
    def index
      @users = User.all
      render json: @users
    end
  
    def create
      user = User.new(user_params)
  
      if user.save
        render json: { name: user.username, email: user.email }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.permit(:username, :email, :password, :password_confirmation,:role,:status)
    end
  end
  