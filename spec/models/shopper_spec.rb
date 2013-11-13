require 'spec_helper'
  describe Shopper do
	before do
		@shopper = build(:shopper)
	end	

	subject { @shopper }

	it "should have valid factory" do
		expect(build(:shopper)).to be_valid
	end
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:zip_code) }
	it { should respond_to(:distance) }
	it { should respond_to(:home_page) }

	context "when email is not present" do
		before { @shopper.email = " " }
		it { should_not be_valid }
	end

	context "email address with mixed case" do
    	let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    	it "should be saved as all lower-case" do
      		@shopper.email = mixed_case_email
      		@shopper.save
      		expect(@shopper.reload.email).to eq mixed_case_email.downcase
    	end
  	end

	context "when an email format is invalid" do
		it "should be invalid" do
			addresses = %w[shopper@test,com shopper_at_test.org test.shopper@test. test@_bar_buz.com test@bar+baz.com]
			addresses.each do |invalid_address|
				@shopper.email = invalid_address
				expect(@shopper).not_to be_valid
			end
		end
	end

	context "when an email format is valid" do
		it "should be invalid" do
			addresses = %w[shopper@test.COM A_TEST-GA@U.G.b.org test.1st@test.foo a+b@test.cn]
			addresses.each do |valid_address|
				@shopper.email = valid_address
				expect(@shopper).to be_valid
			end
		end
	end

	context "when eamil address is already taken" do
		before do
			shopper_with_same_email = @shopper.dup
			shopper_with_same_email.email = @shopper.email.upcase
			shopper_with_same_email.save
		end
		it { should_not be_valid }
	end

	context "when password is not present" do
		before do
			@shopper = build(:shopper, {password: " ", password_confirmation: " "})
		end
		it { should_not be_valid }
	end

	context "when password doesn't match password_confirmation" do
		before { @shopper.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

 	context "with a password that's too short" do
    	before { @shopper.password = @shopper.password_confirmation = "a" * 5 }
    	it { should be_invalid }
  	end

	context "return value of authenticate method" do
	  	before { @shopper.save }
	  	let(:found_shopper) { Shopper.find_by(email: @shopper.email) }

	  	context "with valid password" do
    		it { should eq found_shopper.authenticate(@shopper.password) }
  		end

  		context "with invalid password" do
    		let(:shopper_for_invalid_password) { found_shopper.authenticate("invalid") }

    		it { should_not eq shopper_for_invalid_password }
    		specify { expect(shopper_for_invalid_password).to be_false }
  		end
	end

	context "return shopper by email match" do
		it "should find shopper with specific email" do
			shopper1 = create(:shopper, email: "shopper1@test.com")
			expect(Shopper.by_email(shopper1.email)).to eq [shopper1]
		end
	end
end
