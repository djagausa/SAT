require 'spec_helper'

describe StoresController do

  describe 'GET #index' do

  	before :each do
  		session[:type] = SAT_BIZ_TYPE
  	end
    context 'with params[:id]' do
      before :each do
        @store = create(:store)
        get :index, id: @store
      end
      it "populate store" do
        expect(assigns(:store)).to eq @store
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
  	before :each do
  		session[:type] = SAT_BIZ_TYPE
  	end
    context "with valid attributes" do
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
      xit "does not save the new store in the database" do
        expect{
          post :create, store: attributes_for(:invalid_store)
        }.to_not change(Store, :count)
      end
      xit "re-renders the :new template"
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
      it "redirects to the store" do
        patch :update, id: @store, store: attributes_for(:store)
        expect(response).to redirect_to @store
      end
    end
  end
    
  describe 'DELETE #destroy' do
    before :each do
  		session[:type] = SAT_BIZ_TYPE
        @store = create(:store)
    end
    it "deletes the store from the database" do
      expect{
        delete :destroy, id: @store
      }.to change(Store, :count).by(-1)
    end
    it "redirects to "
  end
end

