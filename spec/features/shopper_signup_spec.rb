require 'spec_helper'

describe "ShopperSignUp" do

	subject { page }

	describe "signup page" do
		before {visit new_shopper_path }

		let(:submit) { "Create Shopper" }

		it { should have_content('New Shopper') }
		it { should have_title('Shop Around Town') }
		it { should have_link('Home')}

		describe "with invalid information" do
			it "should not create a shopper" do
				expect { click_button submit }.not_to change(Shopper, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Email",			with: "shopper@yahoo.com"
				fill_in "Zip code",			with: "90840"
				fill_in "Password",			with: "foobar123"
				fill_in "confirmation",		with: "foobar123"
			end

			it "should create a shopper" do
				expect { click_button submit }.to change(Shopper, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:shopper) { User.find_by(email: 'shopper@yahoo.com') }

				it { should have_content('Shopper') }
				it { should have_selector('div.alert', text: 'successfully created') }
				it { should have_link('Sign Out') }
			end
		end
	end
	# 	# save_and_open_page
end