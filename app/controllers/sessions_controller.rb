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
      session[:user_id] = user.id
      if user.as_user_type == "Biz"
        session[:type] = SAT_BIZ_TYPE
        redirect_to Biz.find_biz(user.as_user_id)
      else
        session[:type] = SAT_SHOPPER_TYPE
        redirect_to Shopper.find_shopper(user.as_user_id)
      end
  	end
  end

  def destroy
    session[:user_id] = nil
    session[:type] = nil
    redirect_to :root
  end
end
