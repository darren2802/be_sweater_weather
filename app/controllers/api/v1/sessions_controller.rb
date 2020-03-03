class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user)
    else
      render json: { message: 'invalid credentials' }, status: 400
    end
  end
end
