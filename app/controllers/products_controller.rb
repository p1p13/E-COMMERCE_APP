class ProductsController < ApplicationController
  before_action :admin?, only: [:new, :create] 
  before_action :check, only: [:show]
  skip_before_action :logged_in_user, only: [:show]


  def new
    @product =Product.new
  end

  def index
    @products = Product.all
  end

  def show  
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      flash.now[:danger] = @product.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id]) rescue nil
  end

  def update
    @product = Product.find(params[:id]) rescue nil
    if @product.update_attributes(product_params)
      redirect_to @product
    else
      flash.now[:danger] = @product.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def check
    @product = Product.find(params[:id]) rescue nil
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :in_stock, :cost)
  end

end
