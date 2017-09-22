class ShippingDetailsController < ApplicationController

  before_action :get_shipping_details, only:[:show, :edit, :update]

  def new
    @shipping_detail = current_user.shipping_details.build
  end

  def index
    @shipping_details = current_user.shipping_details
  end

  def create
    @shipping_detail = current_user.shipping_details.create(shipping_detail_params)
    if @shipping_detail.save
      flash[:success] = "Shipping Details Added Successfully"
      redirect_to  shipping_detail_path(@shipping_detail)
    else
      flash.now[:danger] = @shipping_detail.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @shipping_detail.nil?
      render 'edit'
    elsif @shipping_detail.update_attributes(shipping_detail_params)
      flash[:success] = "Shipping Details Updated Successfully"
      redirect_to shipping_detail_url(@shipping_detail)
    else
      flash.now[:danger] = @shipping_detail.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def get_shipping_details
    @shipping_detail = ShippingDetail.find(params[:id]) rescue nil
    if @shipping_detail.user != current_user
      @shipping_detail = nil
    end
  end

  def shipping_detail_params
    params.require(:shipping_detail).permit(:address_line1, :address_line2, :address_line3, :zip, :country, :state)
  end
end
