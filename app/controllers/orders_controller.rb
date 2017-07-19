class OrdersController < ApplicationController
  def index
    @orders = Order.joins(:user).joins(:product).select('orders.*, users.name, products.price, products.name as product_name').all
  end
 
  # DELETE method for deleting a product from database based on id
  def destroy
    @order = Order.find(params[:id])
    if @order.delete
      flash[:notice] = 'Order deleted!'
      redirect_to orders_path
    else
      flash[:error] = 'Failed to delete this order!'
      render :destroy
    end
  end
end