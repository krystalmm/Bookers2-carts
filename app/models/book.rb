class Book < ApplicationRecord
  
  belongs_to :user
  has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # book_genreのenum定義
  enum book_genre: [ :Business, :Comics, :Technology, :Another_genre ]
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.looks(searches, words)
    if searches == "perfect_match" #完全一致
      @book = Book.where("title LIKE ?", "#{words}")
    else
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
    
    if searches == "partial_match" #部分一致
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
    
    if searches == "forward_match" #前方一致
      @book = Book.where("title LIKE?", "#{words}%")
    else
      @book = Book.where("title LIKE ?", "%#{words}%")
    end

    if searches == "backward_match" #後方一致
      @book = Book.where("title LIKE ?", "%#{words}")
    else
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
  end
end
