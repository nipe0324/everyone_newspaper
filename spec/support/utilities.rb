def full_title(page_title)
  base_title = "みんなの新聞"
  if page_title.empty?
    base_title
  else
    "#{page_title} | #{base_title}"
  end
end


def login(user, options={})
  if options[:no_capybara]
    # Capybaraを使用していない場合にもサインインする。
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit login_path
  	fill_in "メールアドレス", with: user.email.upcase
  	fill_in "パスワード",			with: user.password
  	click_button "ログイン"
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end