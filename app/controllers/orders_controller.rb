require 'securerandom'
class OrdersController < ApplicationController

  def new
  end

  def create
    @order = current_user.orders.create(order_params) 
    @cart = current_user.cart 
    net_cost = 0
    begin
      Order.transaction do
        if @order.save!      
          count = 0
          @cart.cart_items.each do |cart_item|
            count += 1
            net_cost += cart_item.cost 
            cart_item.destroy!
            product = Product.find(cart_item.product_id)
            stock_left = product.in_stock - cart_item.quantity
            product.update_attributes!(in_stock: stock_left)
            order_item_params = { product_id: cart_item.product_id, quantity: cart_item.quantity }
            @order_item = @order.order_items.create!(order_item_params)
          end
          if count == 0
            raise 'your cart is empty'
          end
          @order.update_attributes!(transaction_id: SecureRandom.hex(10), net_cost: net_cost, status: "Order Recieved")
          redirect_to order_path(@order)
          OrderMailer.order_email(current_user, @order).deliver_later
        end 
      end
    rescue Exception => e
      flash.now[:danger] = e.message
      render 'new'
    end   
  end

  def show
    @order = Order.where(user_id: session[:user_id]).last
  end

  private
  def order_params
    params.require(:order).permit(:net_cost, :payment_mode, :shipping_details_id)
  end
end
