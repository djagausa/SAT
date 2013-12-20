require 'spec_helper'

describe StoresController do

  describe 'GET #index' do
    context 'populates an array of products' do
      before :each do
        session[:type] = SAT_BIZ_TYPE
        @store1 = create(:store)
        @store2 = create(:store)
        get :index
      end
      it "populate store" do
        expect(assigns(:stores)).to match_array ([@store1, @store2])
      end
      it "renders the :index view" do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
  	before :each do
  		session[:type] = SAT_BIZ_TYPE
        @store = create(:store)
        get :show, id: @store
    end
    it "assigns the requested store to @store" do
      expect(assigns(:store)).to eq @store
    end
    it "renders the show template" do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
  	before :each do
  		session[:type] = SAT_BIZ_TYPE
        get :new
    end
    it "create a new store" do
      expect(assigns(:store)).to be_kind_of(Store)
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
  	before :each do
      controller.class.skip_before_filter :current_biz
      controller.class.skip_before_filter :authorize_biz
  		session[:type] = SAT_BIZ_TYPE
      @store = create(:store)
      get :edit, id: @store
    end
    it "assigns the requested store to @store" do
      expect(assigns(:store)).to eq @store
    end
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    context "with valid attributes" do
      before :each do
        session[:type] = SAT_BIZ_TYPE
      end
      it "saves the new store in the database" do
      	biz = create(:biz)
        expect{
          post :create, :biz_id =>1, store: attributes_for(:store )
        }.to change(Store, :count).by(1)
      end
      it "redirects to store#show" do
        post :create, :biz_id =>1, store: attributes_for(:store )
        expect(response).to redirect_to store_path(assigns[:store])
      end
    end

    context "with invalid attributes" do
      before :each do
        session[:type] = SAT_BIZ_TYPE
      end
      xit "does not save the new store in the database" do
        expect{
          post :create, :biz_id =>1, store: attributes_for(:invalid_store )
        }.to_not change(Store, :count)
      end
      xit "renders the :new template" do
          post :create, :biz_id =>1, store: attributes_for(:invalid_store)
          expect(response).to render_template :new
      end
    end
  end

  describe 'PUT/PATCH #update' do
  	before :each do
  		session[:type] = SAT_BIZ_TYPE
      @store = create(:store)
    end
    context "with valid attributes" do
      it "locates the request @store" do
        patch :update, id: @store, store: attributes_for(:store)
        expect(assigns(:store)).to eq(@store)
      end
      xit "redirects to the store" do
        patch :update, id: @store, store: attributes_for(:store)
        expect(response).to redirect_to @store
      end
    end
  end
    
  describe 'DELETE #destroy' do
    before :each do
  		session[:type] = SAT_BIZ_TYPE
      controller.class.skip_before_filter :current_biz
      controller.class.skip_before_filter :authorize_biz
      @store = create(:store)
    end
    it "deletes the store from the database" do
      expect{
        delete :destroy, id: @store
      }.to change(Store, :count).by(-1)
    end
    it "redirects to the :index template" do
      delete :destroy, id: @store
      expect(response).to redirect_to stores_url
    end
  end
end

