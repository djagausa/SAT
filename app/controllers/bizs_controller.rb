class BizsController < ApplicationController
  before_action :set_biz, only: [:show, :edit, :update, :destroy]

  # GET /bizs
  # GET /bizs.json
  def index
    @bizs = Biz.all
  end

  # GET /bizs/1
  # GET /bizs/1.json
  def show

  end

  # GET /bizs/new
  def new
    @biz = Biz.new
    @biz.stores.build
  end

  # GET /bizs/1/edit
  def edit
    # @biz = Biz.find(current_user.biz)
  end

  # POST /bizs
  # POST /bizs.json
  def create
    @biz = Biz.new(biz_params)

    respond_to do |format|
      if @biz.save
        format.html { redirect_to @biz, notice: 'Biz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @biz }
      else
        format.html { render action: 'new' }
        format.json { render json: @biz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bizs/1
  # PATCH/PUT /bizs/1.json
  def update
    respond_to do |format|
      if @biz.update(biz_params)
        format.html { redirect_to @biz, notice: 'Biz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @biz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bizs/1
  # DELETE /bizs/1.json
  def destroy
    @biz.destroy
    respond_to do |format|
      format.html { redirect_to bizs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biz
      @biz = Biz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biz_params
      params.require(:biz).permit(:name, :email, :website, :logo, :password, :password_confirmation,
                    stores_attributes:[:id, :street1, :street2, :city, :state, :zip_code, 
                                       :phone_number, :contact_name, :hours, :days, :latitude, :longitude, :biz_id])
    end
end
