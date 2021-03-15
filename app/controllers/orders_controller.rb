class OrdersController < ApplicationController
  before_action :set_cart, only: [:create]

  def new
    @cart = Cart.where(user_id: current_user.id)
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @carts = Cart.where(user_id: current_user.id)
    if params[:order][:address_option] == "0"
      @order.postcode = current_user.postcode
    elsif params[:order][:address_option] == "1"
      @order.postcode = current_user.postcode
    elsif params[:order][:address_option] == "2"
      @order.postcode = params[:order][:postcode]
      @order.address = params[:order][:address]
      @order.address_name = params[:order][:address_name]
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @cart.destroy_all
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

  def set_cart
    @cart = Cart.where(user_id: current_user.id)
  end
end
