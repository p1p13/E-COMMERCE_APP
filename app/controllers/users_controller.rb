class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :admin?, only: [:edit, :update, :index, :show] 
  before_action :get_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) rescue nil
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      SignUpMailer.welcome_email(@user).deliver_later
      flash[:success] = "Signup Successful"
      @user.create_cart
      login @user
    else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit_profile
  end

  def update_profile
    if @user.update_attributes(update_params)
      flash[:success] = "Profile Updated Successfully"
      redirect_to root_url
    else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render 'edit_profile'
    end
  end

  def destroy
    user = User.find(params[:id]) rescue nil
    if user.destroy
      flash.now[:success] = "user removed"
    else
      flash.now[:danger] = user.errors.full_messages.join(', ')
    end
    @users = User.all
    render 'index'
  end

  private
  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def update_params
    params.require(:user).permit(:first_name,  :last_name,
      :permanent_address, :contact_number, :country_code
    )
  end
end
