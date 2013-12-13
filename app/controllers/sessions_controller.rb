class SessionsController < ApplicationController
	def new
  end

  def create
    session[:type] = SAT_SHOPPER_TYPE
  	user = Shopper.authenticate(params[:email], params[:password])

  	if user.nil?
  		user = Biz.authenticate(params[:email], params[:password])
      session[:type] = SAT_BIZ_TYPE
  	end

  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination."
      session[:type] = nil
  		redirect_to :root
  	else
      session[:user_id] = user.id
  		redirect_to user
  	end
  end

  def destroy
    session[:user_id] = nil
    session[:type] = nil
    redirect_to :root
  end
end
