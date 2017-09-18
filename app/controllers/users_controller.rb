class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :show, :edit_profile, :update_profile, :profile]
  before_action :is_admin?, only: [:edit, :update, :show] 


  before_action :get_user, only: [:edit, :update, :edit_profile, :update_profile, :profile, :show]

  def new
    @user = User.new
  end


  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login @user
      #to do: cart creation should be handled by create method of carts controller
      @user.create_cart
    else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
  end

  def profile
    render 'show'
  end

  def edit_profile
  end

  def update_profile
    if @user.update_attributes(update_params)
      redirect_to profile_users_path
    else
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render 'users/edit_profile'
    end
  end


  def update
  end

  def get_user
    @user = User.find(session[:user_id]) rescue nil 
  end
  
  private


  def user_params
    params.require(:user).permit(:email, :password)
  end

  def update_params
    params.require(:user).permit(:first_name,  :last_name,
      :permanent_address, :contact_number, :country_code
    )
  end
end
