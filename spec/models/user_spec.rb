require 'rails_helper'

RSpec.describe User, :type => :model do

	before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

	subject { @user }

	it { should respond_to :name }
	it { should respond_to :email }
	it { should respond_to :password_digest }
	it { should respond_to :password }
	it { should respond_to :password_confirmation }
	it { should respond_to :remember_token }
	it { should respond_to :authenticate }
	it { should respond_to :admin }
	it { should respond_to :articles }
  it { should respond_to :avatar }


	it { should be_valid }

	context "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	context "when name is too long" do
    it "should be valid" do
      @user.name = "a" * 50
      expect(@user).to be_valid
    end

		it "should_not be valid due to too long name" do
      @user.name = "a" * 51
      expect(@user).not_to be_valid
    end
	end

	context "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	context "when email format is invalid" do
		it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
			end
		end
	end

	context "when email format is valid" do
		it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
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
      @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
	end

	context "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end


  describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by(email: @user.email) }

  	context "with valid password" do
  		it { should eq found_user.authenticate(@user.password) }
  	end

  	context "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

  		it { should_not eq user_for_invalid_password }
  	end
  end

  describe "remember token" do
    before { @user.save }
    it { expect(@user.remember_token).not_to be_blank }
  end

  context "with admin attribute set to true" do
  	before do
  		@user.save!
  		@user.toggle!(:admin)
  	end

  	it { should be_admin }
  end

  describe "article associations" do
  	before { @user.save }
    let(:category) { FactoryGirl.create(:category) }
  	let!(:older_article) do
  		FactoryGirl.create(:article, user: @user, category: category, created_at: 1.day.ago)
  	end
  	let!(:newer_article) do
  		FactoryGirl.create(:article, user: @user, category: category, created_at: 1.hour.ago)
  	end

  	it "should have the right article in the right order" do
  		expect(@user.articles.to_a).to eq [newer_article, older_article]
  	end

  	it "should destroy associated articles" do
  		articles = @user.articles.to_a
  		@user.destroy
  		expect(articles).not_to be_empty
  		articles.each do |article|
  			expect(Article.where(id: article.id)).to be_empty
  		end
  	end
  end

end
