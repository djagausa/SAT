require 'spec_helper'

describe BizsController do

  describe 'GET #index' do
    context 'populates an array of bizs' do
    	before :each do
        controller.class.skip_before_filter :current_biz
        session[:type] = SAT_BIZ_TYPE
        @biz1 = create(:biz)
        @biz2 = create(:biz)
        get :index
    	end
      it "populate biz" do
        expect(assigns(:bizs)).to match_array ([@biz1, @biz2])
      end
      it "renders the :index view" do
      	expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    before :each do
      controller.class.skip_before_filter :current_biz
      session[:type] = SAT_BIZ_TYPE
      @biz = create(:biz)
      get :show, id: @biz
    end

    it "assigns the requested biz to @biz" do
      expect(assigns(:biz)).to eq @biz
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before  :each do
      session[:type] = SAT_BIZ_TYPE
      get :new
    end
    it "create a new biz" do
      expect(assigns(:biz)).to be_kind_of(Biz)
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before :each do
      controller.class.skip_before_filter :current_biz
      session[:type] = SAT_BIZ_TYPE
      @biz = create(:biz)
      get :edit, id: @biz
    end
    it "assigns the requested biz to @biz" do
      expect(assigns(:biz)).to eq @biz
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
      xit "saves the new biz in the database" do
        expect{
          post :create, biz: attributes_for(:biz)
        }.to change(Biz, :count).by(1)
      end
      xit "redirects to biz#show" do
        post :create, biz: attributes_for(:biz)
        expect(response).to redirect_to biz_path(assigns[:biz])
      end
    end

    context "with invalid attributes" do
    	before :each do
      		session[:type] = SAT_BIZ_TYPE
		  end 
      it "does not save the new biz in the database" do
        expect{
          post :create, biz: attributes_for(:invalid_biz)
        }.to_not change(Biz, :count)
      end
    end
  end

  describe 'PUT/PATCH #update' do
    before :each do
      session[:type] = SAT_BIZ_TYPE
      @biz = create(:biz)
    end
    context "with valid attributes" do
      it "locates the request @biz" do
        patch :update, id: @biz, biz: attributes_for(:biz)
        expect(assigns(:biz)).to eq(@biz)
      end
      it "redirects to the biz" do
        patch :update, id: @biz, biz: attributes_for(:biz)
        expect(response).to redirect_to @biz
      end
    end
  end
    
  describe 'DELETE #destroy' do
    before :each do
      controller.class.skip_before_filter :current_biz
      session[:type] = SAT_BIZ_TYPE
      @biz = create(:biz)
    end
    it "deletes the biz from the database" do
      expect{
        delete :destroy, id: @biz
      }.to change(Biz, :count).by(-1)
    end
    it "redirects to the :index template" do
      delete :destroy, id: @biz
      expect(response).to redirect_to bizs_url
    end
  end
end
