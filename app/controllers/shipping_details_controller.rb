class ShippingDetailsController < ApplicationController

  before_action :logged_in_user
  before_action :get_user

  def new
    @shipping_detail = @user.shipping_details.build
  end

  def index
    @shipping_details = ShippingDetail.where(user_id: params[:user_id]) rescue nil
  end

  def create
    @shipping_detail = @user.shipping_details.create(shipping_detail_params)
    if @shipping_detail.save
      flash[:success] = "Shipping Details Added Successfully"
      redirect_to  user_shipping_detail_path(@user, @shipping_detail)
    else
      flash.now[:danger] = @shipping_detail.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
  end

  def edit
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
  end

  def update
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
    if @shipping_detail.update_attributes(shipping_detail_params)
      flash[:success] = "Shipping Details Updated Successfully"
      redirect_to user_shipping_detail_url(@user, @shipping_detail)
    else
      render 'show'
    end
  end

  def get_user
    @user = User.find(session[:user_id]) rescue nil 
  end

  private
  def shipping_detail_params
    params.require(:shipping_detail).permit(:address_line1, :address_line2, :address_line3, :zip, :country, :state)
  end

end
