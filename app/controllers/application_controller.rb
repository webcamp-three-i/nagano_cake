class ApplicationController < ActionController::Base
	# 管理者側ログイン後
	def after_sign_in_path_for(resource)
		case resource
		when Admin
			admins_top_path
		end
	end
end
