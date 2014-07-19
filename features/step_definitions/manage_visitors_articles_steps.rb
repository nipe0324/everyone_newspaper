Given(/^I have no account$/) do
	User.delete_all
end

Given(/^I have (\d+) account$/) do |number|
	FactoryGirl.create(:user)
end


When(/^I enter signup information \("(.*?)", "(.*?)", "(.*?)"\)$/) do |name, email, password|
  fill_in "名前",      		with: name
  fill_in "メールアドレス",	with: email
  fill_in "パスワード",   		with: password
  fill_in "確認用パスワード", 	with: password
  click_button "アカウントを作成する"
end


When(/^I enter login information \("(.*?)", "(.*?)"\)$/) do |email, password|
  fill_in "メールアドレス",	with: email
  fill_in "パスワード",   		with: password
  click_button "ログイン"
end