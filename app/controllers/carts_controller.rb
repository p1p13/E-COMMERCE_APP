class CartsController < ApplicationController

  before_action :get_cart_items

  def add_to_cart
    cart = current_user.cart
    if CartItem.find_by({ product_id: params[:product_id], cart_id:  cart.id } )
      flash[:danger] = "Product is already added to your cart.You can update the quantity from here"
      redirect_to go_to_cart_cart_index_path
    else
      @product = Product.find(params[:product_id])
      cart_item_params = { quantity: 1, cost: @product.cost, product_id: params[:product_id] }
      @cart_item = cart.cart_items.create(cart_item_params) 
      if @cart_item.save
        flash[:success] = "Congrats!, Product added to your cart"
      else
        flash[:danger] = @cart_item.errors.full_messages.join(', ')
      end
      redirect_to go_to_cart_cart_index_path
    end
  end

  def go_to_cart
    render 'show'
  end

  def update_quantity
    cart_item = CartItem.find(params[:cart_item_id])
    product = cart_item.product
    quantity = params[:cart_item][:quantity]
    if quantity.to_i > product.in_stock
      flash.now[:error] = "Not in stock"
      render 'show'
    elsif cart_item.update_attributes(quantity: quantity, cost: product.cost * quantity.to_i)
      redirect_to go_to_cart_cart_index_path
    else
      flash.now[:danger] = cart_item.errors.full_messages.join(', ')
      render 'show'
    end
  end

  def remove_cart_item
    cart_item = CartItem.find(params[:cart_item_id])
    if cart_item.destroy
      flash[:success] = "cart item removed"
      redirect_to go_to_cart_cart_index_path
    else
      flash.now[:danger] = cart_item.errors.full_messages.join(', ')
      render 'show'
    end
  end

  private
  def get_cart_items
    @cart_items = current_user.cart.cart_items.order(:created_at)
  end

end
