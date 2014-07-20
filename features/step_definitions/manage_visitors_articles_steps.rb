
Given(/^I have no account$/) do
	User.delete_all
end

Given(/^I have an account as "(.*?)", "(.*?)", "(.*?)"$/) do |name, email, password|
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

Given(/^I have (\d+) article the title of which is "(.*?)" as "(.*?)"$/) do |number, title, email|
  user = User.find_by(email: email)
  user.articles.create!(title: title, content: "dummy")
end

Given(/^I do not login$/) do
end

Given(/^I already logined as "(.*?)", "(.*?)"$/) do |email, password|
  user = User.create(name: "testuser", email: email,
    password: password, password_confirmation: password)

  visit login_path
  fill_in "メールアドレス", with: user.email.upcase
  fill_in "パスワード",      with: user.password
  click_button "ログイン"
end

Given(/^Im on the new article page of "(.*?)"$/) do |email|
  user = User.find_by(email: email)
  visit new_user_article_path(user)
end

Given(/^Im on the edit article page of which is "(.*?)" as "(.*?)"$/) do |title, email|
  user = User.find_by(email: email)
  article = Article.find_by(title: title)
  visit new_user_article_path(user, article)
end

Given(/^Im on the update profile page of "(.*?)"$/) do |email|
  user = User.find_by(email: email)
  visit edit_user_path user
end

Given(/^Im on the profile page of "(.*?)"$/) do |email|
  user = User.find_by(email: email)
  visit user_path user
end

When(/^I enter signup information as "(.*?)", "(.*?)", "(.*?)"$/) do |name, email, password|
  fill_in "名前",      		with: name
  fill_in "メールアドレス",	with: email
  fill_in "パスワード",   		with: password
  fill_in "確認用パスワード", 	with: password
  click_button "アカウントを作成する"
end

When(/^I enter article information as "(.*?)", "(.*?)"$/) do |title, content|
  fill_in "タイトル",  with: title
  fill_in "本文",      with: content
  click_button "記事を投稿する"
end

When(/^I enter login information as "(.*?)", "(.*?)"$/) do |email, password|
  fill_in "メールアドレス",	with: email
  fill_in "パスワード",   		with: password
  click_button "ログイン"
end

When(/^I update profile information as "(.*?)", "(.*?)", "(.*?)"$/) do |name, email, password|
  fill_in "名前", with: name
  fill_in "メールアドレス", with: email.upcase
  fill_in "パスワード",      with: password
  fill_in "確認用パスワード",      with: password
  click_button "更新する"
end
