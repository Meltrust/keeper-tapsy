class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

    def create
     user = User.create(user_params)
      if user.save
         render json: { token: JsonWebToken.encode(sub: user.id) },     
        status: 200
      else
       render json: { message: user.errors.full_messages }, status: 400
   end
  end
 private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
 end
