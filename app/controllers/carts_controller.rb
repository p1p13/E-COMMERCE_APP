class CartsController < ApplicationController
  def new
  end

  def show
    @user = current_user rescue nil
    @cart = @user.cart
  end

  def add_to_cart
    @user = current_user rescue nil
    @cart = @user.cart
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
    @user = User.find(session[:user_id])
    @cart = @user.cart
    render 'show'
  end

   private
  def cart_item_params
    params.permit(:quantity, :product_id, :cost)
  end


end
