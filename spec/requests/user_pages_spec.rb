require 'rails_helper'

RSpec.describe "UserPages", :type => :request do

	subject { page }

  describe "index" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      login admin
      visit users_path
    end

    it { should have_title "ユーザ一覧" }
    it { should have_content "ユーザ一覧" }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector("li", text: user.name)
        end
      end
    end

    describe "delete links" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('削除', href: user_path(User.first)) }
      it "should be able to delete another user" do
        expect do
          click_link('削除', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('削除', href: user_path(admin)) }
    end
  end

  describe "singup(new)" do
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
        it { should have_link "ログアウト" }
		  	it { should have_selector("div.alert.alert-success", text: "ようこそ") }
  		end
	  end
  end

  describe "profile(show)" do
  	let(:user) { FactoryGirl.create(:user) }
    let!(:a1) { FactoryGirl.create(:article, user: user, title: "foo", content: "foo") }
    let!(:a2) { FactoryGirl.create(:article, user: user, title: "bar", content: "bar") }

  	before { login user }

  	it { should have_content user.name }
  	it { should have_title full_title(user.name) }

    describe "articles" do
      it { should have_content a1.title }
      it { should have_content a1.content }
      it { should have_content a2.title }
      it { should have_content a2.content }
      it { should have_content user.articles.count }
    end
  end

  describe "setting(edit)" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      login user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_title "プロフィール更新" }
      it { should have_content "プロフィール更新" }
      it { should have_content "削除する" }
    end

    context "with invalid information" do
      before { click_button "更新する" }
      it { should have_content "エラー" }
    end

    context "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "名前",         with: new_name
        fill_in "メールアドレス",  with: new_email
        fill_in "パスワード",      with: user.password
        fill_in "確認用パスワード",   with: user.password
        click_button "更新する"
      end

      it { should have_title new_name }
      it { should have_success_message "" }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "delete account" do
      it "should be able to delete my account" do
        expect do
          click_link('削除する')
        end.to change(User, :count).by(-1)
      end

      context "after delete" do
        before { click_link "削除する" }

        it { should have_title "みんなの新聞" }
        it { should have_content "ご利用ありがとうございました。" }
      end
    end
  end
end
