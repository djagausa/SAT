require 'spec_helper'

describe "NewProductPage" do

	subject { page }

	describe "new product page" do
		
		before do
			@biz = create(:biz) 
			visit new_biz_product_path(@biz.id)
		end

		let(:submit) { "Create Product" }

		it { should have_content('New Product') }
		it { should have_title('Shop Around Town') }
		it { should have_link('Home')}

		describe "with invalid information" do
			it "should not create a product" do
				expect { click_button submit }.not_to change(Product, :count)
			end
		end

		# describe "with valid information" do
		# 	before do
		# 		fill_in "Email",			with: "shopper@yahoo.com"
		# 		fill_in "Zip code",			with: "90840"
		# 		fill_in "Password",			with: "foobar123"
		# 		fill_in "confirmation",		with: "foobar123"
		# 	end

		# 	it "should create a shopper" do
		# 		expect { click_button submit }.to change(Shopper, :count).by(1)
		# 	end

		# 	describe "after saving the user" do
		# 		before { click_button submit }
		# 		let(:shopper) { User.find_by(email: 'shopper@yahoo.com') }

		# 		it { should have_content('Shopper') }
		# 		it { should have_selector('div.alert', text: 'successfully created') }
		# 		it { should have_link('Sign Out') }
		# 	end
		# end
	end
	# 	# save_and_open_page
end