class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset
  	redirect_to root_url, :notice => "Email sent with password reset instruction."
  end
end
