class Customer::ProductsController < ApplicationController
	before_action :authenticate_customer!, only: [:show]

	def index
		@genres = Genre.all
		@products = Product.where(sales_status: true).page(params[:page]).per(8)
	end

	def show
		@genres = Genre.all
		@product = Product.find(params[:id])
		@cart_item = CartItem.new
	end

	private
	def product_params
		parmas.require(:product).permit(:image ,:name, :description, :price_without_tax, :sales_status)
	end
end
