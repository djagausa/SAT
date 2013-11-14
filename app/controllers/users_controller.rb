class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :edit]
  
  def index
    if params[:email]
      @users = User.by_email(params[:email])
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def edit

  end

  def show
  end

  def delete
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

   # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :user_type, :password, :password_confirmation)
    end
end
