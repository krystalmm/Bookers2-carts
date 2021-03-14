class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    @book_comments = book.book_comments
    if comment.save
      render :create
      flash[:notice] = "You have created comment successfully."
    else
      render 'books/show'
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    @book_comments = BookComment.all
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
