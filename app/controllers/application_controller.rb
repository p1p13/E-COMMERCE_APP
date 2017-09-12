class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      #store_location
      flash[:danger] = "Please log in to continue"
      redirect_to login_path
    end
  end

  def is_admin?
    unless current_user.admin?
      flash[:danger] = "YOU DON'T HAVE PERMISSIONS TO ACCESS THE PAGE"
      redirect_to(root_url)
    end
  end

   def authorized_user
    @user = User.find(params[:user_id]) rescue nil
    unless current_user?(@user)
      flash[:danger] = "YOU ARE NOT AUTHORIZED FOR THIS ACTION"
      redirect_to(root_url)
    end 
  end
end
