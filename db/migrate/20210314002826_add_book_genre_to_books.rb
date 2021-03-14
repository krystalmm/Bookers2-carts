class AddBookGenreToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_genre, :integer, null: false, default: 0
  end
end
