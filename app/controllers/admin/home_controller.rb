class Admin::HomeController < ApplicationController
	before_action :authenticate_admin!

	def top
		now = Time.current
		@order_today = Order.where(created_at: now.all_day)
	end
end
