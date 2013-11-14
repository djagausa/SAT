require 'spec_helper'

describe Product do
	before do
		@product = build(:product)
	end

	it "should have a valid factory" do
		expect(build(:product)).to be_valid
	end

	subject { @product }

	it { should respond_to(:name) }
	it { should respond_to(:description) }
	it { should respond_to(:original_price) }
	it { should respond_to(:sale_price) }
	it { should respond_to(:from_date) }
	it { should respond_to(:to_date) }


	context "when name is not present" do
		before { @product.name = " " }
		it { should_not be_valid}
	end

	context "name must be unique" do
		it "invalid when the names are the same" do
			p1=create(:product, name: "test")
			expect(build(:product, name: "test")).to have(1).errors_on(:name)
		end
	end

	context "when original price is not present" do
		before { @product.original_price = " " }
		it { should_not be_valid}
	end

	context "when sale price is not present" do
		before { @product.sale_price = " " }
		it { should_not be_valid}
	end

	context "when from date is not present" do
		before { @product.from_date = " " }
		it { should_not be_valid}	
	end

	context "when to date is not present" do
		before { @product.to_date = " " }
		it { should_not be_valid}
	end

	context "Associations" do
		it { should respond_to(:store) }
	end

	context "Associations" do
		it { should respond_to(:category) }
	end

	it "has a category" do
		expect(create(:product).category).to be_valid
	end
end
