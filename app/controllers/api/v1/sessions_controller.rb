class Api::V1::SessionsController < ApplicationController
  def create
    p "====="
    p params
    p "====="
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      payload = {user_id: user.id}
      token = encode_token(payload)
      p "====="
      p token
      p "====="
      session[:user_id] = user.id
      p "======="
      p session
      p "======="
      render :json => {user: user, jwt: token}
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

  def auto_login
    # p "----------"
    # p request.headers['Authorization']
    # p "==="
    if current_user
      render :json => current_user
    else
      render :json => {errors: "no!!!"}
    end
  end
end
