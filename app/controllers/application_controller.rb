class ApplicationController < ActionController::Base
	
  protect_from_forgery with: :exception
  before_action :logged_in_user

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in to continue"
			redirect_to login_sessions_path
		end
	end

	def admin?
		unless current_user.admin?
			flash[:danger] = "YOU DON'T HAVE PERMISSIONS TO ACCESS THE PAGE"
			redirect_to(root_url)
		end
	end

	def logout
    session.delete(:user_id)
    @current_user = nil
  end

   def login(user)
    session[:user_id] = user.id
    redirect_to edit_profile_users_path
  end

  def current_user?(user)
    user == current_user
  end


  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :logged_in?, :current_user

end
	
