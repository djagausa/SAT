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
end
