class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :is_admin?, only: [:new, :create] 
  before_action :check, only: [:show]

  def new
  end

  def index
    @products = Product.all
  end

  def show  
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to @product
  end

  def check
    @product = Product.find(params[:id]) rescue nil
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :in_stock, :cost)
  end

end
