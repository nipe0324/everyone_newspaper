require 'rails_helper'

RSpec.describe Article, :type => :model do

	let(:user) { FactoryGirl.create(:user) }
	before { @article = user.articles.build(title: "title", content: "content") }

	subject { @article }

	it { should respond_to :title }
	it { should respond_to :content }
	it { should respond_to :user_id }
	it { should respond_to :user }
	it { expect(user).to eq user }

	it { should be_valid }

	context "with blank title" do
		before { @article.title = " " }
		it { should_not be_valid }		
	end

	context "with title that is too long" do
		before { @article.title = "a" * 41 }
		it { should_not be_valid }		
	end

	context "with blank content" do
		before { @article.content = " " }
		it { should_not be_valid }		
	end

	context "with content that is too long" do
		before { @article.content = "a" * 1001 }
		it { should_not be_valid }		
	end

	context "when user_id is not present" do
		before { @article.user_id = nil }
		it { should_not be_valid }
	end
end
