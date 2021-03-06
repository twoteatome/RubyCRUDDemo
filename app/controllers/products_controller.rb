class ProductsController < ApplicationController
  # GET method to get all products from database
  def index
    @products = Product.joins(:user).select('products.*, users.name as user_name').all
  end
 
  # GET method to get a product by id
  def show
    @product = Product.joins(:user).select('products.*, users.name as user_name').find(params[:id])
  end
 
  # GET method for the new product form
  def new
    @product = Product.new
  end
 
  # POST method for processing form data
  def create
    @product = Product.new(product_params)
    @product.user = @current_user

    if @product.save
      flash[:notice] = 'Product added!'
      redirect_to root_path
    else
      flash[:error] = 'Failed to edit product!'
      render :new
    end
  end
 
   # GET method for editing a product based on id
  def edit
    @product = Product.find(params[:id])
  end
 
  # PUT method for updating in database a product based on id
  def update
    @product = Product.find(params[:id])
    @product.user = @current_user

    if @product.update_attributes(product_params)
      flash[:notice] = 'Product updated!'
      redirect_to root_path
    else
      flash[:error] = 'Failed to edit product!'
      render :edit
    end
  end

  def buy
    @order = Order.where(:user_id => session[:user_id]).where(:product_id => params[:product_id]).first
    if @order.blank?
      @order = Order.new
      @order.user = User.find_by id: session[:user_id]
      @order.product = Product.find(params[:product_id])
      @order.quantity = 1
      @order.status = 0
    elsif @order.status != 0
      @order = Order.new
      @order.user = User.find_by id: session[:user_id]
      @order.product = Product.find(params[:product_id])
      @order.quantity = 1
      @order.status = 0
    else
      @order.quantity = 1 + @order.quantity
    end

    if @order.save
      flash[:notice] = 'Product bought!'
    else
      flash[:error] = 'Failed to buy product!'
    end
  end
 
  # DELETE method for deleting a product from database based on id
  def destroy
    @product = Product.find(params[:id])
    if @product.delete
      flash[:notice] = 'Product deleted!'
      redirect_to root_path
    else
      flash[:error] = 'Failed to delete this product!'
      render :destroy
    end
  end
 
  # we used strong parameters for the validation of params
  def product_params
    params.require(:product).permit(:name, :price, :short_description, :full_description)
  end
end
