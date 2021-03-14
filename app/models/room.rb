class Room < ApplicationRecord
  # ———DM機能・userとのアソシエーション——————————
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  # ———DM機能・chatとのアソシエーション——————————
  has_many :chats, dependent: :destroy
  # —————————————————————————————————————————————
end
