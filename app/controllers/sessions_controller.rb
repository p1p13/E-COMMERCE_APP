class SessionsController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login user
    else
      flash.now[:danger] = "Check your email/password"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
