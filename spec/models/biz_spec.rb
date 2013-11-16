require 'spec_helper'

describe Biz do
    before do
		@biz = build(:biz)
	end	

	it "should have a valid factory"  do
		expect(build(:biz)).to be_valid
	end

	subject { @biz }

	it { should respond_to(:name) }
	it { should respond_to(:website) }
	it { should respond_to(:logo_image) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	context "when name is not present" do
		before { @biz.name = " " }
		it { should_not be_valid }
	end

	context "Associations" do
		it { should respond_to(:shoppers) }
	end

	context "Associations" do
		it { should respond_to(:stores) }
	end

	context "Associations" do
		it { should respond_to(:products) }
	end

	context "email address with mixed case" do
    	let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    	it "should be saved as all lower-case" do
      		@biz.email = mixed_case_email
      		@biz.save
      		expect(@biz.reload.email).to eq mixed_case_email.downcase
    	end
  	end

	context "when an email format is invalid" do
		it "should be invalid" do
			addresses = %w[biz@test,com biz_at_test.org test.biz@test. test@_bar_buz.com test@bar+baz.com]
			addresses.each do |invalid_address|
				@biz.email = invalid_address
				expect(@biz).not_to be_valid
			end
		end
	end

	context "when an email format is valid" do
		it "should be invalid" do
			addresses = %w[biz@test.COM A_TEST-GA@U.G.b.org test.1st@test.foo a+b@test.cn]
			addresses.each do |valid_address|
				@biz.email = valid_address
				expect(@biz).to be_valid
			end
		end
	end

	context "when eamil address is already taken" do
		before do
			biz_with_same_email = @biz.dup
			biz_with_same_email.email = @biz.email.upcase
			biz_with_same_email.save
		end
		it { should_not be_valid }
	end

	context "when password is not present" do
		before do
			@biz = build(:biz, {password: " ", password_confirmation: " "})
		end
		it { should_not be_valid }
	end

	context "when password doesn't match password_confirmation" do
		before { @biz.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

 	context "with a password that's too short" do
    	before { @biz.password = @biz.password_confirmation = "a" * 5 }
    	it { should be_invalid }
  	end

	context "return value of authenticate method" do
	  	before { @biz.save }
	  	let(:found_biz) { Biz.find_by(email: @biz.email) }

	  	context "with valid password" do
    		it { should eq found_biz.authenticate(@biz.password) }
  		end

  		context "with invalid password" do
    		let(:biz_for_invalid_password) { found_biz.authenticate("invalid") }

    		it { should_not eq biz_for_invalid_password }
    		specify { expect(biz_for_invalid_password).to be_false }
  		end
	end

	context "return biz by email match" do
		it "should find biz with specific email" do
			biz1 = create(:biz, email: "biz1@test.com")
			expect(Biz.by_email(biz1.email)).to eq [biz1]
		end
	end
end
