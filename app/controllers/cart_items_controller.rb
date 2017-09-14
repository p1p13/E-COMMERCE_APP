class CartItemsController < ApplicationController
  def new  
    @product_id = params[:product_id]
    @user = User.find(session[:user_id]) rescue nil
    @cart = @user.cart
    @cart_item = @cart.cart_items.build
    @product = Product.find(params[:product_id])
  end

  def create
    @user = current_user rescue nil
    @product = Product.find(params[:cart_item][:product_id])
    @cart = @user.cart
    params[:cart_item][:cost] = params[:cart_item][:quantity] * @product.cost.to_f
    @cart_item = @cart.cart_items.create(cart_item_params) 
    if @cart_item.save
      flash[:success] = "Congrats!, Product added to your cart"
      redirect_to user_cart_path(@user, @cart)
    else
      flash[:danger] = @cart_item.errors.full_messages.join(', ')
      render 'new'
    end
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cost)
  end

end
