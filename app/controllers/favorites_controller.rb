class FavoritesController < ApplicationController
  before_action :book_params

  def create
    @favorite = Favorite.create(user_id: current_user.id, book_id: @book.id)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id).destroy
  end

  private

  def book_params
    @book = Book.find(params[:book_id])
  end
end
