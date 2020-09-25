class Customer::ProductsController < ApplicationController
	before_action :authenticate_customer!, only: [:show]

	def index
		@genres = Genre.where(valid_flag: true)
		# ジャンル検索された場合とそうでない場合
		if params["genre"]
			@products = Product.where(genre_id: params["genre"]).page(params[:page]).per(8)
			@genre = Genre.find(params["genre"])
		else
			@products = Product.where(sales_status: true).page(params[:page]).per(8)
		end
	end

	def show
		@genres = Genre.where(valid_flag: true)
		@product = Product.find(params[:id])
		@cart_item = CartItem.new
	end

	private
	def product_params
		parmas.require(:product).permit(:image ,:name, :description, :price_without_tax, :sales_status)
	end
end
