class BizsController < ApplicationController
  before_action :authorize_biz, only: [:destroy, :edit, :update, :index, :show]
  before_action :set_biz, only: [:show, :edit, :update, :destroy]
  before_action :current_biz, only: [:destroy, :edit, :update, :index, :show]

  # GET /bizs
  # GET /bizs.json
  def index
    @bizs = Biz.all
  end

  # GET /bizs/1
  # GET /bizs/1.json
  def show
    @stores = @biz.stores
    @products = Product.by_biz_id(@biz)
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
    if @biz.save
      user = User.authenticate(params[:biz][:email], params[:biz][:password])
      sign_in(user)
      redirect_to @biz, notice: 'Biz was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bizs/1
  # PATCH/PUT /bizs/1.json
  def update
      if @biz.update(biz_params)
        redirect_to @biz, notice: 'Biz was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /bizs/1
  # DELETE /bizs/1.json
  def destroy
    @biz.destroy
    redirect_to bizs_url
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
                                       :phone_number, :contact_name, :hours, :days, :lat, :lng, :biz_id])
    end

    def current_biz
      redirect_to(root_url) unless current_user?(User.find_user(params[:id], 'Biz'))
    end
end
