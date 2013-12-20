class SessionsController < ApplicationController
	def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.nil?
        flash.now[:error] = "Invalid email/password combination."
        session[:type] = nil
        redirect_to :root
    else
    	sign_in(user)
      if user.as_user_type == "Biz"
        redirect_to Biz.find_biz(user.as_user_id)
      else
        redirect_to Shopper.find_shopper(user.as_user_id)
      end
    end
  end

  def destroy
    session[:user_id] = nil
    session[:type] = nil
    cookies.delete(:auth_token)
    redirect_to :root
  end
end
