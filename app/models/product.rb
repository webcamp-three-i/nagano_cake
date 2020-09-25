class Product < ApplicationRecord
	belongs_to :genre
	has_many :order_products, dependent: :destroy
	has_many :cart_items, dependent: :destroy
	attachment :image

	validates :genre_id, :name, :description, :price_without_tax, :sales_status, presence: true
  validates :description, length: {maximum: 200}
end
