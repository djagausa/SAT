module SessionsHelper
	def sat_sign_in(user)
		session[:as_user_id] = user.as_user_id
		session[:user_id] = user.id
		if params[:remember_me]
		   cookies.permanent[:auth_token] = user.auth_token
		else
		   cookies[:auth_token] = user.auth_token
		end
		if user.as_user_type == "Biz"
        	session[:type] = SAT_BIZ_TYPE
      	else
        	session[:type] = SAT_SHOPPER_TYPE
      	end
	end
end