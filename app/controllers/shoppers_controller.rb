class ShoppersController < ApplicationController
  before_action :set_shopper, only: [:show, :edit, :update, :destroy]
  before_action :authorize_shopper, only: [:edit, :update, :destroy, :show, :index]
  before_action :correct_shopper, only: [:edit, :update, :destroy, :show, :index]

  # GET /shoppers
  # GET /shoppers.json
  def index
    @shoppers = Shopper.all
  end

  # GET /shoppers/1
  # GET /shoppers/1.json
  def show
    @stores=Store.get_products("category_ids" => @shopper.categories.pluck(:id),"zip_code" => @shopper.zip_code,"distance" => @shopper.distance)
    render action: 'index'
  end

  # GET /shoppers/new
  def new
    @shopper = Shopper.new
  end

  # GET /shoppers/1/edit
  def edit
  end

  # POST /shoppers
  # POST /shoppers.json
  def create
    @shopper = Shopper.new(shopper_params)
    if @shopper.save
      user = User.authenticate(params[:shopper][:email], params[:shopper][:password])
      sign_in(user)
      product_cats = params[:shopper][:category_ids][0...-1]
      @shopper.categories = product_cats.map {|id| Category.find(id)}
      redirect_to @shopper, notice: 'Shopper was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /shoppers/1
  # PATCH/PUT /shoppers/1.json
  def update
    if @shopper.update(shopper_params)
      redirect_to @shopper, notice: 'Shopper was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /shoppers/1
  # DELETE /shoppers/1.json
  def destroy
    @shopper.destroy
    redirect_to shoppers_url
  end

  def search
    @stores=Store.get_products( "category_ids" => params[:shopper][:category_ids][0...-1],
                                "zip_code" => params[:shopper][:zip_code],
                                "distance" => params[:shopper][:distance])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopper
      @shopper = Shopper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopper_params
      params.require(:shopper).permit(:email, :zip_code, :distance, :home_page, :lat, :lng, :password, :password_confirmation)
    end

    def correct_shopper
      redirect_to(root_url) unless current_user?(User.find_user(params[:id], 'Shopper'))
    end
end
