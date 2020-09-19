class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	# ログイン後
	def after_sign_in_path_for(resource)
		case resource
		when Admin
			admins_top_path
		when Customer
			root_path
		end
	end

	# 顧客側新規登録
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :postal_code, :residence, :phone_number, :is_valid])
	end
end
