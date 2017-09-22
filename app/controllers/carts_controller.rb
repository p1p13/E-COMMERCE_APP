class CartsController < ApplicationController

  before_action :get_cart_items

  def add_to_cart
    cart = current_user.cart
    if CartItem.find_by({ product_id: params[:product_id], cart_id:  cart.id } )
      flash[:danger] = "Product is already added to your cart.You can update the quantity from here"
    else
      @product = Product.find(params[:product_id]) rescue nil
      cart_item_params = { quantity: 1, cost: @product.cost, product_id: params[:product_id] }
      @cart_item = cart.cart_items.create(cart_item_params) 
      if @cart_item.save
        flash[:success] = "Congrats!, Product added to your cart"
      else
        flash[:danger] = @cart_item.errors.full_messages.join(', ')
      end
    end
    redirect_to your_cart_cart_index_path

  end

  def your_cart
    render 'show'
  end

  def update_quantity
    cart_item = CartItem.find(params[:cart_item_id]) rescue nil
    product = cart_item.product
    quantity = params[:cart_item][:quantity]
    if cart_item.nil? || cart_item.cart.user != current_user
      flash[:error] = "Either the item doesn't exist or this item doesn't belong to you"
    elsif quantity.to_i > product.in_stock
      flash[:error] = "Not in stock"
    elsif cart_item.update_attributes(quantity: quantity, cost: product.cost * quantity.to_i)
      flash[:success] = "quantity updated"
    else
      flash[:danger] = cart_item.errors.full_messages.join(', ')
    end
    redirect_to your_cart_cart_index_path

  end

  def remove_cart_item
    cart_item = CartItem.find(params[:cart_item_id]) rescue nil
    cart_item.product_id = nil
    if cart_item.nil? || cart_item.cart.user != current_user
      flash[:error] = "Either the item doesn't exist or this item doesn't belong to you"
    elsif cart_item.destroy
      flash[:success] = "cart item removed"
    else
      flash[:danger] = cart_item.errors.full_messages.join(', ')
    end
    redirect_to your_cart_cart_index_path
  end

  private
  def get_cart_items
    @cart_items = current_user.cart.cart_items.order(:created_at)
  end

end
