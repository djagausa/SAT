class SessionsController < ApplicationController
	def new
  end

  def create

  	user = Shopper.authenticate(params[:session][:email], params[:session][:password])

  	if user.nil?
  		user = Biz.authenticate(params[:session][:email], params[:session][:password])
  	end

  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination."
  		redirect_to :root
  	else
  		redirect_to user
  	end

  end

end
