class Order < ApplicationRecord
  belongs_to :user

  enum payment_selection: { クレジットカード: 0, 銀行振込: 1 }
  enum order_status: { 入金待ち: 0 }
  enum postage: { "800": 0 }
end
