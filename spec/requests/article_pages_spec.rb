require 'rails_helper'

RSpec.describe "Article pages", :type => :request do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { login user }
  
  describe "create article" do
    before { visit new_article_path }

    it { should have_title full_title("記事を投稿") }
    it { should have_content "記事を投稿" }

    let(:submit) { "記事を投稿する" }

    context "with invalid information" do
      it "should not create an article" do
        expect { click_button submit }.not_to change(Article, :count)
      end

      context "after submission" do
        before { click_button submit }

        it { should have_title full_title("記事を投稿") }
        it { should have_content "記事を投稿" }
        it { should have_content "エラー" }
      end
    end

    context "with valid information" do
      before do
        fill_in "タイトル", with: "タイトル123"
        fill_in "本文",  with: "コンテンツ"
      end

      it "should create an article" do
        expect { click_button submit }.to change(Article, :count).by(1)
      end

      context "after saving the article" do
        before { click_button submit }
        let(:article) { Article.find_by(name: "タイトル123") }

        it { should have_title full_title(user.name) }
        it { should have_content user.name }
        it { should have_success_message "記事を投稿しました。" }
      end
    end
  end

  describe "update article" do
    let(:article) { FactoryGirl.create(:article, user: user) }
    before do
      login user
      visit edit_user_path(user, article)
    end

    it { should have_title "記事を編集" }
    it { should have_content "記事を編集" }

    context "with invalid information" do
      before { click_button "記事を更新する" }
      it { should have_content "エラー" }
    end

    context "with valid information" do
      let(:new_title) { "New Title" }
      let(:new_content) { "New Content" }
      before do
        fill_in "タイトル", with: new_title
        fill_in "本文", with: new_content
        click_button "記事を更新する"
      end

      it { should have_title user.name }
      it { should have_success_message "記事を更新しました。" }
      specify { expect(article.reload.title).to eq new_title }
      specify { expect(article.reload.content).to eq new_content }
    end
  end

  describe "delete article" do
    before { visit user }

    it "should be able to delete my article" do
      expect do
        click_link('削除')
      end.to change(Article, :count).by(-1)
    end

    context "after delete" do
      before { click_link "削除" }

      it { should have_title user.name }
      it { should have_content user.name }
    end
  end
end