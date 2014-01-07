class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    if user
  	   user.send_password_reset
  	   redirect_to root_url, :notice => "Email sent with password reset instruction."
     else
      flash.now[:error] = "Email not found!"
      render :new
    end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
	  @user = User.find_by_password_reset_token!(params[:id])
	  if @user.password_reset_sent_at < 2.hours.ago
	    redirect_to new_password_reset_path, :alert => "Password reset has expired."
	  elsif @user.update(user_params)
	    redirect_to root_url, :notice => "Password has been reset!"
	  else
	    render :edit
	  end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
