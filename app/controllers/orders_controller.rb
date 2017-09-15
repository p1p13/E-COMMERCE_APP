require 'securerandom'

class OrdersController < ApplicationController

  def new
    @user = User.find(session[:user_id]) rescue nil
    @cart =@user.cart
  end

  def create
    @user = User.find(session[:user_id])
    #to do: payment method to be added 
    @order = @user.orders.create(order_params) 
    params[:order_items] = {}
    @cart = @user.cart rescue nil
    net_cost = 0
    if @order.save
      #to do: order item creation should be handled by create method of order_items controller

      @cart.cart_items.each do |cart_item|
        net_cost += cart_item.product.cost * (cart_item.quantity || 0) 
        params[:order_items][:product_id] = cart_item.product_id
        params[:order_items][:quantity] = cart_item.quantity
        cart_item.destroy
        @order_item = @order.order_items.create(order_item_params)
      end
      @order.update(transaction_id: SecureRandom.hex(10), net_cost: net_cost)
      redirect_to order_path(@order)
    else
      flash.now[:danger] = @order.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
    @order = Order.last
  end

  private
  def order_params
    params.require(:order).permit(:net_cost, :payment_mode, :shipping_details_id)
  end

  private
  def order_item_params()
    params.require(:order_items).permit(:product_id, :quantity)
  end

end
