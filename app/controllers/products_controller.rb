class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
     respond_to do |format|
        format.html { @products = Product.all }
        format.js { @products = Category.find(params[:category_id]).products.includes(:biz).includes(:store)}
      end
  end


  # GET /products/1
  def show
    @categories=Category.all
    @biz = Biz.find(@product.biz_id)
    @stores = @biz.stores
  end

  # GET /products/new
  def new
    @biz = Biz.find(params[:biz_id])
    @product = @biz.products.new
    @categorization = Categorization.new 
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @biz = Biz.find(params[:biz_id])
    @product = @biz.products.new(product_params)
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
      params.require(:product).permit(:sale_price, :name, :original_price, :from_date, :to_date, :category_id, :description, :photo, :biz_id)
    end
end