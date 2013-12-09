require 'spec_helper'

describe Store do
  	before do
		subject { build(:store) }
	end	

	it "creates a valid factory" do
		expect(create(:store)).to be_valid
	end
	
	it { should respond_to(:street1) }
	it { should respond_to(:street2) }
	it { should respond_to(:city) }
	it { should respond_to(:state) }
	it { should respond_to(:zip_code) }
	it { should respond_to(:phone_number) }
	it { should respond_to(:contact_name) }
	it { should respond_to(:hours) }
	it { should respond_to(:days) }

	describe "Associations" do
		it { should respond_to(:biz) }
	end

	it "has a biz" do
		expect(create(:store).biz).to be_valid
	end


end
