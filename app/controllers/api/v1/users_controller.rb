class Api::V1::UsersController < ApplicationController
  def create
    return render json: { message: 'missing field' }, status: 400 if params.values.any? { |param| param == "" || param.nil? }
    return render json: { message: 'passwords do not match' }, status: 400 unless params[:password] == params[:password_confirmation]
    params[:api_key] = generate_api_key
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { message: 'email already taken' }, status: 400 if User.where(email: user.email)
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
