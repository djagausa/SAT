require 'spec_helper'

describe CategoriesController do

  describe 'GET #index' do
    context 'populates an array of categories' do
      before :each do
      	controller.class.skip_before_filter :authorize_admin
        @cat1 = create(:category)
        @cat2 = create(:category)
        get :index
      end
      it "populate cat" do
        expect(assigns(:categories)).to match_array ([@cat1, @cat2])
      end
      it "renders the :index view" do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    before :each do
      controller.class.skip_before_filter :authorize_admin
      @cat = create(:category)
      get :show, id: @cat
    end

    it "assigns the requested category to @category" do
      expect(assigns(:category)).to eq @cat
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before  :each do
      controller.class.skip_before_filter :authorize_admin
      get :new
    end
    it "create a new category" do
      expect(assigns(:category)).to be_kind_of(Category)
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before :each do
      controller.class.skip_before_filter :authorize_admin
      @category = create(:category)
      get :edit, id: @category
    end
    it "assigns the requested category to @category" do
      expect(assigns(:category)).to eq @category
    end
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    context "with valid attributes" do
      before :each do
        controller.class.skip_before_filter :authorize_admin
      end
      it "saves the new category in the database" do
        expect{
          post :create, category: attributes_for(:category)
        }.to change(Category, :count).by(1)
      end
      it "redirects to category#show" do
        post :create, category: attributes_for(:category)
        expect(response).to redirect_to category_path(assigns[:category])
      end
    end
  end

  describe 'PUT/PATCH #update' do
    before :each do
      controller.class.skip_before_filter :authorize_admin
      @category = create(:category)
    end
    context "with valid attributes" do
      it "locates the request @category" do
        patch :update, id: @category, category: attributes_for(:category)
        expect(assigns(:category)).to eq(@category)
      end
      it "redirects to the category" do
        patch :update, id: @category, category: attributes_for(:category)
        expect(response).to redirect_to @category
      end
    end
  end
    
  describe 'DELETE #destroy' do
    before :each do
      controller.class.skip_before_filter :authorize_admin
      @category = create(:category)
    end
    it "deletes the category from the database" do
      expect{
        delete :destroy, id: @category
      }.to change(Category, :count).by(-1)
    end
    it "redirects to the :index template" do
      delete :destroy, id: @category
      expect(response).to redirect_to categories_url
    end
  end
end
