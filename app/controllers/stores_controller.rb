class StoresController < ApplicationController
  before_filter :authorize_biz
  before_action :set_store, :only => [:show, :edit, :update, :destroy]
  # GET /store
  def index
    @stores = Store.all
  end

  # GET /store /1  
  def show
  end

  # GET /store/new
  def new
    @store = Store.new
  end

  # GET /store/1/edit
  def edit
  end

  # PATCH/PUT /store/1
  def update
    if @store.update(store_params)
      redirect_to @store, notice: "Store was successfully updated"
    else
      render action :edit
    end
  end

  # POST /store
  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to @store, notice: 'Store was successfully created'
    else
      render action :new
    end
  end  

  # DELETE /store/1
  def destroy
    @store.destroy
    redirect_to @store, notice: 'Store was successfully deleted'
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:street1, :street2, :city, :state, :zip_code, 
                                       :phone_number, :contact_name, :hours, :days, :lat, :lng, :biz_id)
  end

end
