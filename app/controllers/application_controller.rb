class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def current_user? (user)
    user == current_user
  end

  helper_method :authorize_biz, :authorize_admin, :authorize_shopper, :current_user

  protected
  def biz?
  	session[:type] == SAT_BIZ_TYPE
  end

  def authorize_biz
  	unless biz?
  		flash[:error] = "Unauthorized access!"
  		redirect_to root_path
  		false
  	end
  end

  def shopper?
  	session[:type] == SAT_SHOPPER_TYPE
  end

  def authorize_shopper
  	unless shopper?
  		flash[:error] = "Unauthorized access!"
  		redirect_to root_path
  		false
  	end
  end

  def admin?
  	current_user.try(:admin?)
  end

  def authorize_admin
  	unless admin?
  		flash[:error] = "Unauthorized access!"
  		redirect_to root_path
  		false
  	end
  end
end
