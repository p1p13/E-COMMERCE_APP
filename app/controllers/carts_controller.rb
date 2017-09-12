class CartsController < ApplicationController
  def new
  end

  def show
    @user = current_user rescue nil
    @cart = @user.cart
  end

end
