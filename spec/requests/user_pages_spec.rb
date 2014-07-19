require 'rails_helper'

RSpec.describe "UserPages", :type => :request do

	subject { page }

  describe "singup" do
  	before { visit signup_path }

  	it { should have_content "ユーザアカウント登録" }
  	it { should have_title full_title("ユーザアカウント登録") }

  	let(:submit) { "アカウントを作成する" }

  	context "with invalid information" do
  		it "should not create a user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end

  		context "after submission" do
  			before { click_button submit }

		  	it { should have_title full_title("ユーザアカウント登録") }
		  	it { should have_content "ユーザアカウント登録" }
		  	it { should have_content "エラー" }
  		end
  	end

  	context "with valid information" do
  		before do
			  fill_in "名前",      		with: "testuser"
			  fill_in "メールアドレス",	with: "testuser@example.com"
			  fill_in "パスワード",   		with: "foobarbar"
			  fill_in "確認用パスワード", 	with: "foobarbar"
  		end

  		it "should create a user" do
  			expect { click_button submit }.to change(User, :count).by(1)
  		end

  		context "after saving the user" do
  			before { click_button submit }
  			let(:user) { User.find_by(email: "testuser@example.com") }

		  	it { should have_title full_title(user.name) }
		  	it { should have_content user.name }
		  	it { should have_selector("div.alert.alert-success", text: "ようこそ") }
  		end
	  end

  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content user.name }
  	it { should have_title full_title(user.name) }
  end
end
