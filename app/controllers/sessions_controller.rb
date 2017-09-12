class SessionsController < ApplicationController
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
