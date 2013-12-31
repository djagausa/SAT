
require 'spec_helper'

describe "FAQ" do

	subject { page }

	describe "should display FAQ page" do
		before {visit root_path }

		it { should have_title('Shop Around Town') }
		it { should have_link('FAQ')}

		it "displays FAQs info" do
			click_link "FAQ"
			page.should have_content ('Faq')
		end
	end
	# 	# save_and_open_page
end