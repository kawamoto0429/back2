module ApplicationHelper
  def logged_in_user(pal)
    user = User.find(pal[:user_id])
    p "====="
    p user
    p "====="
    user.password_digest == pal[:password]
  end
end
