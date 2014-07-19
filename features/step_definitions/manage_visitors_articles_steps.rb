Given(/^I have no account$/) do
	User.delete_all
end

When(/^I enter valid information \("(.*?)", "(.*?)", "(.*?)"\)$/) do |name, email, password|
  fill_in "名前",      		with: name
  fill_in "メールアドレス",	with: email
  fill_in "パスワード",   		with: password
  fill_in "確認用パスワード", 	with: password
  click_button submit
end