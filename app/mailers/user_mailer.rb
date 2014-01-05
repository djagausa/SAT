class UserMailer < ActionMailer::Base
  default from: "admin@sat.com"

  def password_reset(user)
    @user = user

    mail :to => user.email, :subject => "Password Reset"
  end

  def contact_us(contact)
  	@contact = contact
  	mail :to => 'sat_contact_us@sat.com', :subject => "Contact Request"
  end
end
