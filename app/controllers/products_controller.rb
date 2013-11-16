class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
     respond_to do |format|
        format.html { @products = Product.all }
        format.js { @products = Category.find(params[:category_id]).products.includes(:store)}
      end
  end


  # GET /products/1
  def show
    @categories=Category.all
    @store = Store.find(@product.store_id)
  end

  # GET /products/new
  def new
    @store = Store.find(params[:store_id])
    @product = Product.new
    @categorization = Categorization.new 
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Store.find(params[:store_id]).products.new(product_params)
    # @product.store_id = params[:store_id]
    if @product.save
      # render text: params
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /products/1
  def update

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:sale_price, :name, :original_price, :start_date, :end_date, :category_id, :description, :photo)
    end
end