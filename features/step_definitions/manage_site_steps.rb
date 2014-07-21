Given(/^I already logined as admin$/) do
	@admin = FactoryGirl.create(:admin)
	visit login_path
  fill_in "メールアドレス", with: @admin.email
  fill_in "パスワード", with: @admin.password
  click_button "ログイン"
end

When(/^I enter login information as admin$/) do
  fill_in "メールアドレス", with: @admin.email
  fill_in "パスワード", with: @admin.password
  click_button "ログイン"
end

When(/^I enter update article information as "(.*?)", "(.*?)", "(.*?)"$/) do |title, cateogory_name, content|
  fill_in "タイトル", with: title
  select cateogory_name, from: "カテゴリ"
  fill_in "本文", with: content
  click_button "記事を更新する"
end

Given(/^I am on the mypage of admin$/) do
	visit user_path(@admin)
end