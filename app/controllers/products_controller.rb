class ProductsController < ApplicationController

  before_action :admin?, only: [:new, :create] 
  skip_before_action :logged_in_user, only: [:show, :index]
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def show  
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
  end

  def update
    if @product.nil?
      redirect_to @product
    elsif @product.update_attributes(product_params)
      flash[:success]  = "Product Updated"
      redirect_to @product
    else
      flash.now[:danger] = @product.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    @products = Product.all
    if @product.nil?
      flash[:error] = "product does not exist"
    elsif @product.destroy
      flash[:success] = "product removed"
    else
      flash[:danger] = product.errors.full_messages.join(', ')
    end
    redirect_to products_path

  end

  private

  def get_product
    @product = Product.find(params[:id]) rescue nil
  end

  def product_params
    params.require(:product).permit(:title, :description, :in_stock, :cost, :image)
  end
end
