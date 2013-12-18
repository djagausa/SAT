require 'spec_helper'

describe User do
  before do
    @user = build(:user)
  end 
  
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

 
  context "email address with mixed case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it "should be saved as all lower-case" do
          @user.email = mixed_case_email
          @user.save
          expect(@user.reload.email).to eq mixed_case_email.downcase
      end
  end

  context "when an email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@test,com user_at_test.org test.user@test. test@_bar_buz.com test@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "when an email format is valid" do
    it "should be invalid" do
      addresses = %w[user@test.COM A_TEST-GA@U.G.b.org test.1st@test.foo a+b@test.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  context "when password is not present" do
    before do
      @user = build(:user, {password: " ", password_confirmation: " "})
    end
    it { should_not be_valid }
  end

  context "when password doesn't match password_confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  context "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  context "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }

      context "with valid password" do
        it { should eq found_user.authenticate(@user.password) }
      end

      context "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not eq user_for_invalid_password }
          specify { expect(user_for_invalid_password).to be_false }
      end
  end

  context "return user by email match" do
    it "should find user with specific email" do
      user1 = create(:user, email: "user1@test.com")
      expect(User.by_email(user1.email)).to eq [user1]
    end
  end
end