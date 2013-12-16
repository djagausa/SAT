class ShoppersController < ApplicationController
  before_action :set_shopper, only: [:show, :edit, :update, :destroy]

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

    respond_to do |format|
      if @shopper.save
        session[:type] = SAT_SHOPPER_TYPE
        session[:user_id] = @shopper.id
        product_cats = params[:shopper][:category_ids][0...-1]
        @shopper.categories = product_cats.map {|id| Category.find(id)}
        format.html { redirect_to @shopper, notice: 'Shopper was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shopper }
      else
        format.html { render action: 'new' }
        format.json { render json: @shopper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoppers/1
  # PATCH/PUT /shoppers/1.json
  def update
    respond_to do |format|
      if @shopper.update(shopper_params)
        format.html { redirect_to @shopper, notice: 'Shopper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shopper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoppers/1
  # DELETE /shoppers/1.json
  def destroy
    @shopper.destroy
    respond_to do |format|
      format.html { redirect_to shoppers_url }
      format.json { head :no_content }
    end
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
      params.require(:shopper).permit(:email, :zip_code, :distance, :home_page, :password, :password_confirmation, :lat, :lng)
    end
end
