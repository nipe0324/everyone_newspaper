require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :request do

	subject { page }

	context "with valid information" do
		let(:user) { FactoryGirl.create(:user) }
		before { login user }

		it { should have_title user.name }
		it { should have_link "プロフィール", href: user_path(user) }
		it { should have_link "設定", href: edit_user_path(user) }
		it { should have_link "ログアウト", href: logout_path }
		it { should_not have_link "ログイン", href: login_path }
	end

	describe "authorization" do

		context "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			context "visiting the user index" do
				before { visit users_path }
				it { should have_title "ログイン" }
			end

			context "visiting the user page" do
				before { visit user_path(user) }
				it { should have_title "ログイン" }
			end

			context "visiting the edit page" do
				before { visit edit_user_path(user) }
				it { should have_title "ログイン" }
			end

			context "submitting to the update action" do
				before { patch user_path(user) }
				specify { expect(response).to redirect_to login_path }
			end

			context "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "メールアドレス", with: user.email
					fill_in "パスワード", with: user.password
					click_button "ログイン"
				end

				context "after login" do
					it "should render the desired protected page" do
						expect(page).to have_title "プロフィール更新"
					end
				end
			end
		end

		context "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { login user, no_capybara: true }

			context "submitting a GET request to the Users#show action" do
				before { get user_path(wrong_user) }
				specify { expect(response.body).not_to match(wrong_user.name) }
				specify { expect(response).to redirect_to(root_url) }
			end

			context "submitting a GET request to the Users#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match("プロフィール更新") }
				specify { expect(response).to redirect_to(root_url) }
			end

			context "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end

			context "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
				specify { expect(response.body).not_to match("ご利用ありがとうございました。")}
			end
		end

		context "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { login non_admin, no_capybara: true }

			context "visiting the user index" do
				before { visit users_path }
				it { should have_title "ログイン" }
			end

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
		end
	end

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

		context "with valid information as user" do
			let(:user) { FactoryGirl.create(:user) }
			before { login user }

			it { should have_title user.name }
			it { should have_link("プロフィール", href: user_path(user)) }
			it { should have_link("設定", href: edit_user_path(user)) }
			it { should have_link("ログアウト", href: logout_path) }
			it { should_not have_link("ログイン", href: login_path) }

			context "followed by logout" do
				before { click_link "ログアウト" }
				it { should have_link "ログイン" }
			end
		end

		context "with valid information as admin" do
			let(:admin) { FactoryGirl.create(:admin) }
			before { login admin}

			it { should have_title admin.name }
			it { should have_link("ユーザ一覧", href: users_path) }			
			it { should have_link("プロフィール", href: user_path(admin)) }
			it { should have_link("設定", href: edit_user_path(admin)) }
			it { should have_link("ログアウト", href: logout_path) }
			it { should_not have_link("ログイン", href: login_path) }

			context "followed by logout" do
				before { click_link "ログアウト" }
				it { should have_link "ログイン" }
			end
		end

	end
end
