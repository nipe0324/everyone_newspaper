前提(/^なし$/) do
end

もし(/^(.*) にアクセスする$/) do |path|
	visit path
end

ならば(/^(.*) が表示される$/) do |content|
	page.should have_content(content)
end
