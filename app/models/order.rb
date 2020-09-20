class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, dependent: :destroy

  enum payment_method: {
    "クレジットカード": 0,
    "銀行振込": 1
  }
end
