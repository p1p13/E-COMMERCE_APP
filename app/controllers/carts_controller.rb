class CartsController < ApplicationController

  before_action :get_cart  

  def add_to_cart
    @product = Product.find(params[:product_id])
    params[:cost] = @product.cost
    params[:quantity] = 1
    @cart_item = @cart.cart_items.create(cart_item_params) 
    if @cart_item.save
      flash[:success] = "Congrats!, Product added to your cart"
      redirect_to go_to_cart_cart_index_path
    else
      flash[:danger] = @cart_item.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def go_to_cart
    render 'show'
  end

  def update_quantity
    cart_item = CartItem.find(params[:format])
    unless cart_item.update_attributes(params.require(:cart_item).permit(:quantity))
      flash.now[:danger] = @cart_item.errors.full_messages.join(', ')
    end
    render 'carts/show'
  end

  private
  def get_cart
    @cart = current_user.cart
  end

  def cart_item_params
    params.permit(:quantity, :product_id, :cost)
  end
end
