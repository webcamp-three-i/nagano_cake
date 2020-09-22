class Customer::CustomersController < ApplicationController
	before_action :ensure_correct_customer, only: [:show, :edit, :update, :quit, :out]

	def show
		@customer = Customer.find(params[:id])
	end

	def edit
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
	      redirect_to customer_path(current_customer), notice: "Successfully."
	    else
	      render "edit"
    	end
	end

    #退会するユーザーの情報を見つける
	def quit
	    @customer = Customer.find(params[:id])
	end

	#現在ログインしているユーザーを@customerに格納し、updateで登録情報をInvalidに変更
	def out
	    @customer = Customer.find(current_customer.id)
	    if @customer.update(is_valid: "Invalid")
	    	sign_out current_customer
    	end
	    redirect_to root_path
	end

	private
	def customer_params
		params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :postal_code, :residence, :phone_number, :email, :is_valid)
	end

	def ensure_correct_customer
		@customer = Customer.find(params[:id])
		unless @customer == current_customer
		  redirect_to root_path
		end
	end
end
