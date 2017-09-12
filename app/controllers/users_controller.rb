class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action only: [:edit, :update] do
    authorize_user(:id)
  end
  before_action :check_user, only: [:show]

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
      #flash[:danger] = @user.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id]) rescue nil 
  end

  def update
    if @user.update_attributes(update_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def check_user
    @user = User.find(params[:id]) rescue nil 
  end
  
  private


  def user_params
    params.require(:user).permit(:email, :password)
  end

  def update_params
    params.require(:user).permit(:email, :password, :first_name,  :last_name,
      :permanent_address, :contact_number, :country_code
    )
  end
end
