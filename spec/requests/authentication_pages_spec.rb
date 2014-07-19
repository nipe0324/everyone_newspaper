require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :request do

	subject { page }

	describe "login page" do
		before { visit login_path }

		it { should have_title full_title("ログイン") }
		it { should have_content "ログイン" }
	end

	describe "login" do
		before { visit login_path }

		context "with invalid information" do
			before { click_button "ログイン" }

			it { should have_title full_title("ログイン") }
			it { should have_error_message "誤り" }

			context "after visiting another page" do
				before { click_link "みんなの新聞" }
				it { should_not have_error_message "" }
			end
		end

		context "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before { login user }

			it { should have_title user.name }
			it { should have_link("プロフィール", href: user_path(user)) }
			it { should have_link("ログアウト", href: logout_path) }
			it { should_not have_link("ログイン", href: login_path) }

			context "followed by logout" do
				before { click_link "ログアウト" }
				it { should have_link "ログイン" }
			end
		end
	end
end
