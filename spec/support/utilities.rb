def full_title(page_title)
  base_title = "みんなの新聞"
  if page_title.empty?
    base_title
  else
    "#{page_title} | #{base_title}"
  end
end


def login user
	fill_in "メールアドレス", with: user.email.upcase
	fill_in "パスワード",			with: user.password
	click_button "ログイン"
end


RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end