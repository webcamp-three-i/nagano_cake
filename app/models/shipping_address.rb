class ShippingAddress < ApplicationRecord
	belongs_to :customer

	validates :customer_id, :name, :residence, presence: true

	def order_address #注文情報入力画面で、登録済み住所から選択で使用する、自分の住所を定義する(使いやすくまとめておく)。
		self.postal_code + self.residence + self.name #shipping_addresses(配送先)モデルの3つの配送先カラム
	end
end
