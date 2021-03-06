class Api::V1::UsersController < ApplicationController
  def index
    p "====="
    p params[:user]
    p "====="
    if params[:user] != nil
      user = User.find_by(email: params[:user][:email])
      if user && user.authenticate(params[:user][:password]) 
        session[:user_id] = user.id
        render :json =>  user
      else
        render :json => "error"
      end
    else
      render :json => "error"
    end
  end
  def create
    user = User.new(user_params)
    if user.save
      payload = {user_id: user.id}
      token = encode_token(payload)
      session[:user_id] = user.id
      render :json => {user: user, jwt: token}
    else
      render :json => {message: user.errors.full_messages}
    end

  end
  def destory
    user = User.find(params[:id])
    if session[:user_id] = user.id
      session.delete(:user_id)
    else
      render :json => "error"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
