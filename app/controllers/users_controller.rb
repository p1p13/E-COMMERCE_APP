class UsersController < ApplicationController

  before_action :is_admin, only: [:edit, :update, :show] 
  before_action :get_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      @user.create_cart
    else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
  end

  def edit_profile
  end

  def update_profile
    if @user.update_attributes(update_params)
      redirect_to root_url
    else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render 'edit_profile'
    end
  end

  def update
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
