class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, dependent: :destroy
  validates :customer_id, :postal_code, :address, :name, :postage, :billing_amount, :payment_method, :order_status, presence: true

  enum payment_method: {
    "クレジットカード": 0,
    "銀行振込": 1
  }

  enum order_status: {
    "制作不可": 0,
    "制作待ち": 1,
    "制作中": 2,
    "制作完了": 3
  }
end
