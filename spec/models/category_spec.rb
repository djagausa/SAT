require 'spec_helper'

describe Category do
  	before do
		@category = build(:category)
	end	

	it "has a valid factory" do
		expect(build(:category)).to be_valid
	end

	subject { @category }

	context "Associations" do
		it { should respond_to(:products) }
		it { should respond_to(:shoppers) }
	end


	context "when name is not present" do
		before { @category.name = " " }
		it { should_not be_valid }
	end

	context "when name is the same" do
		it "is invalid when the names are the same"  do
			cat1 = create(:category, name: "test1")
			cat2 = build(:category, name: "test1")
			expect(cat2).to have(1).errors_on(:name)
		end
	end
	
end
