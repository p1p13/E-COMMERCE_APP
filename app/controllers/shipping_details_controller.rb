class ShippingDetailsController < ApplicationController

   before_action :logged_in_user
   before_action :authorized_user

  def new
    @user = User.find(params[:user_id]) rescue nil 
    @shipping_detail = @user.shipping_details.build
  end

  def index
    @user = User.find(params[:user_id]) rescue nil 
    @shipping_details = ShippingDetail.where(user_id: params[:user_id])
  end

  def create
    @user = User.find(params[:user_id]) rescue nil 
    @shipping_detail = @user.shipping_details.create(shipping_detail_params)
    if @shipping_detail.save
      flash[:success] = "Shipping Details Added Successfully"
      redirect_to  user_shipping_detail_path(@user, @shipping_detail)
    else
      flash[:danger] = @shipping_detail.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
    #@user = User.find(params[:user_id]) rescue nil 
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
  end

  def edit
    @user = User.find(params[:user_id]) rescue nil 
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
  end

  def update
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
    @user = User.find(params[:user_id]) rescue nil 
    if @shipping_detail.update_attributes(shipping_detail_params)
      flash[:success] = "Shipping Details Updated Successfully"
      redirect_to user_shipping_detail_url(@user, @shipping_detail)
    else
      render 'show'
    end
  end


  private
  def shipping_detail_params
    params.require(:shipping_detail).permit(:address_line1, :address_line2, :address_line3, :zip, :country, :state)
  end

end
