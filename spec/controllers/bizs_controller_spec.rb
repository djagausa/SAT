require 'spec_helper'

# describe BizsController do

#   describe 'GET #index' do
#     context 'with params[:user_id]' do
#     	before :each do
#         @biz = create(:biz)
#         get :index
#     	end
#       it "populate biz" do
#         expect(assigns(:bizs)).to eq [@biz]
#       end
#       it "renders the :index view" do
#       	expect(response).to render_template :index
#       end
#     end
#   end

#   describe 'GET #show' do
#     before :each do
#       @biz = create(:biz)
#       get :show, id: @biz
#     end

#     it "assigns the requested biz to @biz" do
#       expect(assigns(:biz)).to eq @biz
#     end

#     it "renders the show template" do
#       expect(response).to render_template :show
#     end
#   end

#   describe 'GET #new' do
#     before  :each do
#       get :new
#     end
#     it "create a new biz" do
#       expect(assigns(:biz)).to be_kind_of(Biz)
#     end
#     it "renders the new template" do
#       expect(response).to render_template :new
#     end
#   end

#   describe 'GET #edit' do
#     before :each do
#       @biz = create(:biz)
#       get :edit, id: @biz
#     end
#     it "assigns the requested biz to @biz" do
#       expect(assigns(:biz)).to eq @biz
#     end
#     it "renders the :edit template" do
#       expect(response).to render_template :edit
#     end
#   end
  
#   describe 'POST #create' do
#     context "with valid attributes" do
#       it "saves the new contact in the database" do
#         expect{
#           post :create, biz: attributes_for(:biz)
#         }.to change(Biz, :count).by(1)
#       end
#       it "redirects to biz#show" do
#         post :create, biz: attributes_for(:biz)
#         expect(response).to redirect_to biz_path(assigns[:biz])
#       end
#     end

#     context "with invalid attributes" do
#       it "does not save the new biz in the database" do
#         expect{
#           post :create, biz: attributes_for(:invalid_biz)
#         }.to_not change(Biz, :count)
#       end
#     end
#   end

#   describe 'PUT/PATCH #update' do
#     before :each do
#       @biz = create(:biz)
#     end
#     context "with valid attributes" do
#       it "locates the request @biz" do
#         patch :update, id: @biz, biz: attributes_for(:biz)
#         expect(assigns(:biz)).to eq(@biz)
#       end
#       it "redirects to the biz" do
#         patch :update, id: @biz, biz: attributes_for(:biz)
#         expect(response).to redirect_to @biz
#       end
#     end
#   end
    
#   describe 'DELETE #destroy' do
#     before :each do
#       @biz = create(:biz)
#     end
#     it "deletes the biz from the database" do
#       expect{
#         delete :destroy, id: @biz
#       }.to change(Biz, :count).by(-1)
#     end
#     it "redirects to "
#   end
end
