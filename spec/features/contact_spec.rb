require 'spec_helper'

describe "Contact Us" do

	subject { page }

	describe "should display contact page" do
		before {visit root_path }

		it { should have_title('Shop Around Town') }
		it { should have_link('Contact')}

		it "displays contact info" do
			click_link "Contact"
			user = create(:user)
			page.should have_content ('Contact')
			current_path.should eq(new_contact_path)
			fill_in "Email", :with => user.email
			click_button "Submit"
			current_path.should eq(root_path)
			page.should have_content ('Contact request sent')
		end
	end
	# 	# save_and_open_page
end