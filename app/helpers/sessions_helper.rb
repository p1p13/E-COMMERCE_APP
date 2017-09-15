module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    redirect_to '/user'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end
end
