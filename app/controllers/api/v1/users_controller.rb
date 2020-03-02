class Api::V1::UsersController < ApplicationController
  def create
    return render json: UserSerializer.new(user) unless params[:password] == params[:password_confirmation]

    params[:api_key] = generate_api_key
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user)
    else
      render json: UserSerializer.new(user)
    end

  end

  private

    def user_params
      params.permit :email, :password, :api_key
    end

    def generate_api_key
      SecureRandom.base64(21)
    end
end
