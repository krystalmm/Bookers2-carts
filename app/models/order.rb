class Order < ApplicationRecord
  belongs_to :user

  enum payment_selection: { クレジットカード: 0, 銀行振込: 1 }
end
