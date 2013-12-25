require 'spec_helper'

describe "BizSignUp" do

	subject { page }

	describe "signup page" do
		before {visit new_biz_path }

		let(:submit) { "Create Biz" }

		it { should have_content('New Business') }
		it { should have_title('Shop Around Town') }
		it { should have_link('Home')}

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(Biz, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",				with: "test biz"
				fill_in "Email",			with: "testbiz@yahoo.com"
				fill_in "Zip code",			with: "90840"
				fill_in "Password",			with: "foobar123"
				fill_in "confirmation",		with: "foobar123"
			end

			it "should create a user" do
				expect { click_button submit }.to change(Biz, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:biz) { User.find_by(email: 'testbiz@yahoo.com') }

				it { should have_content('test biz') }
				it { should have_selector('div.alert', text: 'successfully created') }
				it { should have_content('New Product') }
			end
		end
	end
	# 	# save_and_open_page
end