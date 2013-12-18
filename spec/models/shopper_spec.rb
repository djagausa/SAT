require 'spec_helper'
  describe Shopper do
	before do
		@shopper = build(:shopper)
	end	

	subject { @shopper }

	it "should have valid factory" do
		expect(build(:shopper)).to be_valid
	end
	
	it { should respond_to(:zip_code) }
	it { should respond_to(:distance) }
	it { should respond_to(:home_page) }
end
