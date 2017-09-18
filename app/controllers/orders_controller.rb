require 'securerandom'

class OrdersController < ApplicationController

  def new
  end

  def create
    @order = current_user.orders.create(order_params) 
    params[:order_items] = {}
    @cart = current_user.cart 
    net_cost = 0
    if @order.save      
      @cart.cart_items.each do |cart_item|
        net_cost += cart_item.product.cost * (cart_item.quantity) 
        params[:order_items][:product_id] = cart_item.product_id
        params[:order_items][:quantity] = cart_item.quantity
        cart_item.destroy
        product = Product.find(cart_item.product_id)
        product.in_stock -= 1
        product.save
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
    @order = Order.find_by(user_id: session[:user_id])
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
