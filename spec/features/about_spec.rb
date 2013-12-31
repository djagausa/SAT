require 'spec_helper'

describe "About" do

	subject { page }

	describe "should display about page" do
		before {visit root_path }

		it { should have_title('Shop Around Town') }
		it { should have_link('About')}

		it "displays about info" do
			click_link "About"
			page.should have_content ('About')
		end
	end
	# 	# save_and_open_page
end