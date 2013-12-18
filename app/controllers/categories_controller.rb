class CategoriesController < ApplicationController
  before_filter :authorize_admin
  before_action :set_category, :only => [:show, :edit, :update, :destroy]

  # GET /caterory
  def index
    @categories=Category.all
  end

  # GET /cagtegory/1
  def show
  end

  # GET /category/new
  def new
    @category = Category.new
  end

  # GET /category/1/edit
  def edit
  end

  # PATCH/PUT /catergory/1
  def update
     if @category.update(category_params)
      redirect_to @category, notice: "Category was successfully updated."
    else
      render action: 'edit'
    end
  end

  # POST /category
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render action: 'new' 
    end
  end

  # DELETE /category/1
  def destroy
    @category.destroy
    redirect_to @category, notice: 'Category was successfully destroyed.'
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
