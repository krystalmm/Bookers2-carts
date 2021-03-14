class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, authentication_keys: [:name]
  devise :registerable, :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :orders, dependent: :nullify

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed  #自分がフォローしている人
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower　#自分をフォローしている人

  # ———DM機能・roomのアソシエーション————————————
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  # ———DM機能・chatのアソシエーション————————————
  has_many :chats, dependent: :destroy
  # —————————————————————————————————————————————
  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def self.looks(searches, words)
    if searches == "perfect_match" #完全一致
      @user = User.where("name LIKE ?", "#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end

    if searches == "partial_match" #部分一致
      @user = User.where("name LIKE ?", "%#{words}%")
    end

    if searches == "forward_match" #前方一致
      @user = User.where("name LIKE?", "#{words}%")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end

    if searches == "backward_match" #後方一致
      @user = User.where("name LIKE ?", "%#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end


