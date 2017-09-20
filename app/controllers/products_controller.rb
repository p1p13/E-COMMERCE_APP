class ProductsController < ApplicationController

  before_action :admin?, only: [:new, :create] 
  skip_before_action :logged_in_user, only: [:show, :index]


  def new
    @product =Product.new
  end

  def index
    @products = Product.all
  end

  def show  
    @product = Product.find(params[:id]) rescue nil
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success]  = "Product Added"
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
      flash[:success]  = "Product Updated"
      redirect_to @product
    else
      flash.now[:danger] = @product.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      flash.now[:success] = "product removed"
    else
      flash.now[:danger] = product.errors.full_messages.join(', ')
    end
    @products = Product.all
    render 'index'
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :in_stock, :cost)
  end
end
