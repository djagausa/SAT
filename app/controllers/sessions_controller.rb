class SessionsController < ApplicationController
	 def new
  end

  def create

  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])

  	else

  	end
  	# user = Shopper.authenticate(params[:session][:email], params[:session][:password])

  	# if user.nil?
  	# 	user = Biz.authenticate(params[:session][:email], params[:session][:password])
  	# end

  	# if user.nil?
  	# 	flash.now[:error] = "Invalid email/password combination."
  	# 	render :home
  	# else
  	# 	redirect_to user
  	# end

  end

  def destroy
  end
end
