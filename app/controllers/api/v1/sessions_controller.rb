class Api::V1::SessionsController < ApplicationController
  def create
    p "====="
    p params
    p "====="
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      p "======="
      p session
      p "======="
      render :json =>  user
    else
      render :json => "error"
    end
  end
  def destroy
    if !session == nil
      session.delete()
      render :json => "logout"
    else
      render :json => "error"
    end
  end
end
