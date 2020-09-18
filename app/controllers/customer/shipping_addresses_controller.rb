class Customer::ShippingAddressesController < ApplicationController
	before_action :authenticate_customer!

	def index
		@shippings_address = current_customer.shippings_address
		@shippings_address = ShippingAddresses.new
	end

	def create
		@shippings_address = ShippingAddresses.new(shipping_addresses_params)
		@shippings_address.customer_id = current_customer.id
		@shipping_addresses = current_customer.shipping_address
		if @shippings_address.save
			redirect_to customer_shipping_addresses_path
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def shipping_address_params
		params.require(:shipping_address).permit(:postal_code, :address, :name)
	end

end

