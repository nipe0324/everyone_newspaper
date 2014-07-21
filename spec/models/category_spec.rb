require 'rails_helper'

RSpec.describe Category, :type => :model do

	before { @category = Category.new(name: "category") }

	subject { @category }

	it { should respond_to :name }
	it { should respond_to :articles }

	it { should be_valid }

	context "when name is not present" do
		before { @category.name = " " }
		it { should_not be_valid }
	end

	context "when name is too long" do
    it "should be valid" do
      @category.name = "a" * 10
      expect(@category).to be_valid
    end

		it "should_not be valid due to too long name" do
      @category.name = "a" * 11
      expect(@category).not_to be_valid
    end
	end



	context "when name is already taken" do
		before do
			category_with_same_name = @category.dup
			category_with_same_name.name = @category.name
			category_with_same_name.save
		end
		it { should_not be_valid }
	end

  describe "article associations" do
  	before { @category.save }
  	let!(:older_article) do
  		FactoryGirl.create(:article, category: @category, created_at: 1.day.ago)
  	end
  	let!(:newer_article) do
  		FactoryGirl.create(:article, category: @category, created_at: 1.hour.ago)
  	end

  	it "should have the right article in the right order" do
  		expect(@category.articles.to_a).to eq [newer_article, older_article]
  	end
  end
end
