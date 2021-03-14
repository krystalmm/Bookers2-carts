class OrdersController < ApplicationController
  def new
    @cart = Cart.where(user_id: current_user.id)
    if @cart.books.empty?
      redirect_to books_path, notice: 'カートは空です'
      return
    end
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @carts = Cart.where(user_id: current_user.id)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to success_orders_path
    else
      render :new
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def success
  end

  private

  def order_params
    params.require(:order).permit(:payment_selection, :postcode, :address, :address_name, :user_id, :postage)
  end
end
