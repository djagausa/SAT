class ProductsController < ApplicationController
  before_action :set_product, :only => [:show, :edit, :update, :destroy]

  # GET /product
  def index
    @product = Category.find(params[:category_id]).products
  end

  # GET /product/1
  def show
  end

  # GET /product/new
  def new
    @product = Category.find(params[:category_id]).products.new
  end
  
  # GET /product/1/edit
  def edit
  end

  # PATCH/PUT /product/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product successfully updated"
    else
      render action: 'edit'
    end
  end

  # POST /product
  def create
    @product = Category.find(params[:category_id]).products.new(product_params)
    if @product.save
      redirect_to @product, notice: "Product successfully created."
    else
      render action: 'new'
    end
  end

  # DELETE /product/1
  def destroy
    @product.destroy
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :original_price, :sale_price,
                                    :from_date, :to_date)
  end
end
