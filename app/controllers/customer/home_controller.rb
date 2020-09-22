class Customer::HomeController < ApplicationController
	def top
		@genres = Genre.where(valid_flag: true)
		@products = Product.all.page(params[:page]).per(4)
	end
end
