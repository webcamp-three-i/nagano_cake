class Product < ApplicationRecord
	belongs_to :genre
	has_many :order_products, dependent: :destroy
	has_many :cart_items, dependent: :destroy
	attachment :image

  validates :description, length: {maximum: 200}
end
