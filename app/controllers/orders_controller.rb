require 'securerandom'
class OrdersController < ApplicationController

  def new
  end

  def create
    binding.pry
    cart = current_user.cart 
    if cart.cart_items.empty?
      flash[:danger] = "your cart is empty"
      redirect_to your_cart_cart_index_path
    else
      @order = current_user.orders.new(payment_mode: "card", shipping_details_id: current_user.shipping_details.first.id);
      net_cost = 0
      cart.cart_items.each do |cart_item|
        net_cost += cart_item.cost 
        order_item_params = { product_id: cart_item.product_id, quantity: cart_item.quantity }
        @order.order_items.build(order_item_params)
      end
      begin
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source => params[:stripeToken]
        )
        charge = Stripe::Charge.create(
          :customer => customer.id,
          :amount => net_cost.to_i,
          :description => 'Rails Stripe customer',
          :currency    => 'usd'
        )
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_order_path
      end
      if @order.save
        @order.update_attributes(transaction_id: SecureRandom.hex(10), net_cost: net_cost, status: "Order Recieved")
        cart.cart_items.each do |cart_item| 
          cart_item.destroy
          product = cart_item.product
          stock_left = product.in_stock - cart_item.quantity
          product.update_attributes(in_stock: stock_left)
        end
        redirect_to order_path(@order)
        OrderMailer.order_email(@order).deliver_later
      else
        flash.now[:danger] = @order.errors.full_messages.join(', ')
        render 'new'
      end 
    end
  end

  def show
    @order = current_user.orders.last
  end
end
