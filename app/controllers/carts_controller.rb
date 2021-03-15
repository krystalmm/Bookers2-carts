class CartsController < ApplicationController
  def index
    @carts = Cart.where(user_id: current_user.id)
  end

  def create
    @cart_book = current_user.carts.create(cart_books_params)
    @cart_book.save
    redirect_to carts_path
  end

  def update
  end

  def destroy
  end

  private
    def cart_books_params
      params.require(:cart).permit(:book_id, :user_id, :quantity)
    end
end
