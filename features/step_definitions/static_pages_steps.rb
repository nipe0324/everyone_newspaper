前提(/^なし$/) do
end

もし(/^(.*) にアクセスする$/) do |path|
	visit path
end

ならば(/^(.*) が表示されること$/) do |page_title|
	page.should have_content(page_title)
end
