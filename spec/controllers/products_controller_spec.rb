require 'spec_helper'

describe ProductsController do

  describe 'GET #index' do
    context 'with params[:id]' do

      before :each do
        @product = create(:product)
        get :index, id: @product
      end
      it "populate product" do
        expect(assigns(:product)).to eq @product
      end
      it "renders the :index view" do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @product = create(:product)
      get :show, id: @product
    end
    it "assigns the requested product to @product" do
      expect(assigns(:product)).to eq @product
    end
    it "renders the show template" do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before  :each do
      session[:type] = SAT_BIZ_TYPE
      @biz = create(:biz)
      get :new, biz_id: @biz
    end
    it "create a new product" do
      expect(assigns(:product)).to be_kind_of(Product)
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before :each do
      session[:type] = SAT_BIZ_TYPE
      @product = create(:product)
      get :edit, id: @product
    end
    it "assigns the requested product to @product" do
      expect(assigns(:product)).to eq @product
    end
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    context "with valid attributes" do
      before :each do
      	session[:type] = SAT_BIZ_TYPE
        @biz = create(:biz)
      end
      it "saves the new contact in the database" do
        expect{
          post :create, biz_id: @biz, product: attributes_for(:product)
        }.to change(Product, :count).by(1)
      end
      it "redirects to product#show" do
        post :create, biz_id: @biz, product: attributes_for(:product)
        expect(response).to redirect_to product_path(assigns[:product])
      end
    end

    context "with invalid attributes" do
      xit "does not save the new product in the database" do
        expect{
          post :create, product: attributes_for(:invalid_product)
        }.to_not change(Product, :count)
      end
      xit "re-renders the :new template"
    end
  end

  describe 'PUT/PATCH #update' do
    before :each do
      session[:type] = SAT_BIZ_TYPE
      @product = create(:product)
    end
    context "with valid attributes" do
      it "locates the request @product" do
        patch :update, id: @product, product: attributes_for(:product)
        expect(assigns(:product)).to eq(@product)
      end
      it "redirects to the product" do
        patch :update, id: @product, product: attributes_for(:product)
        expect(response).to redirect_to @product
      end
    end
  end
    
  describe 'DELETE #destroy' do
    before :each do
      session[:type] = SAT_BIZ_TYPE
      @product = create(:product)
    end
    it "deletes the product from the database" do
      expect{
        delete :destroy, id: @product
      }.to change(Product, :count).by(-1)
    end
    xit "redirects to "
  end
end


