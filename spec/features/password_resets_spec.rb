require 'spec_helper'

describe "PasswordResets" do
	it "emails user when requesting password reset" do
		user = create(:user)
		visit new_session_path
		click_link "password"
		fill_in "Email", :with => user.email
		current_path.should eq(new_password_reset_path)
		click_button "Reset Password"
		current_path.should eq(root_path)
		page.should have_content ('Email sent')
		last_email.to.should include(user.email)

		# save_and_open_page
	end

end