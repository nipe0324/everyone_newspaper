require 'rails_helper'

RSpec.describe Article, :type => :model do

	let(:user) { FactoryGirl.create(:user) }
	let(:category) { FactoryGirl.create(:category) }
	before { @article = user.articles.build(title: "title", content: "content", category: category) }

	subject { @article }

	it { should respond_to :title }
	it { should respond_to :content }
	it { should respond_to :user_id }
	it { should respond_to :user }
	it { expect(user).to eq user }
	it { should respond_to :category_id }
	it { should respond_to :category }
	it { expect(category).to eq category }
	it { should respond_to :picture }

	it { should be_valid }

	context "with blank title" do
		before { @article.title = " " }
		it { should_not be_valid }		
	end

	context "with title that is too long" do
    it "should be valid" do
      @article.title = "a" * 40
      expect(@article).to be_valid
    end
		it "should_not be valid due to too long content" do
      @article.title = "a" * 41
      expect(@article).not_to be_valid
    end
	end

	context "with blank content" do
		before { @article.content = " " }
		it { should_not be_valid }		
	end

	context "with content that is too long" do
    it "should be valid" do
      @article.content = "a" * 5000
      expect(@article).to be_valid
    end
		it "should_not be valid due to too long content" do
      @article.content = "a" * 5001
      expect(@article).not_to be_valid
    end
	end

	context "when user_id is not present" do
		before { @article.user_id = nil }
		it { should_not be_valid }
	end
end
