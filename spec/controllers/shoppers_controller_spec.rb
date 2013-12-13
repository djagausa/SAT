require 'spec_helper'

describe ShoppersController do

  describe 'GET #index' do
    context 'populates an array of shoppers' do
      before :each do
          @shopper1 = create(:shopper)
          @shopper2 = create(:shopper)
          get :index 
      end
      it "populate shopper" do
        expect(assigns(:shoppers)).to match_array ([@shopper1, @shopper2])
      end
      it "renders the :index view" do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @shopper = create(:shopper)
      get :show, id: @shopper
    end

    it "assigns the requested shopper to @shopper" do
      expect(assigns(:shopper)).to eq @shopper
    end

    it "renders the index template" do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before  :each do
      get :new
    end
    it "create a new shopper" do
      expect(assigns(:shopper)).to be_kind_of(Shopper)
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before :each do
      @shopper = create(:shopper)
      get :edit, id: @shopper
    end
    it "assigns the requested shopper to @shopper" do
      expect(assigns(:shopper)).to eq @shopper
    end
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    context "with valid attributes" do
      xit "saves the new contact in the database" do
        expect{
          post :create, shopper: attributes_for(:shopper)
        }.to change(Shopper, :count).by(1)
      end
      xit "redirects to shopper#show" do
        post :create, shopper: attributes_for(:shopper)
        expect(response).to redirect_to shopper_path(assigns[:shopper])
      end
    end

    context "with invalid attributes" do
      xit "does not save the new shopper in the database" do
        expect{
          post :create, shopper: attributes_for(:invalid_shopper)
        }.to_not change(Shopper, :count)
      end
      xit "re-renders the :new template"
    end
  end

  describe 'PUT/PATCH #update' do
    before :each do
      @shopper = create(:shopper)
    end
    context "with valid attributes" do
      it "locates the request @shopper" do
        patch :update, id: @shopper, shopper: attributes_for(:shopper)
        expect(assigns(:shopper)).to eq(@shopper)
      end
      it "redirects to the shopper" do
        patch :update, id: @shopper, shopper: attributes_for(:shopper)
        expect(response).to redirect_to @shopper
      end
    end
  end
    
  describe 'DELETE #destroy' do
    before :each do
      @shopper = create(:shopper)
    end
    it "deletes the shopper from the database" do
      expect{
        delete :destroy, id: @shopper
      }.to change(Shopper, :count).by(-1)
    end
    it "redirects to "
  end
end
