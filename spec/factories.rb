FactoryGirl.define do
	factory :user do
		sequence(:name)		{ |n| "testuser#{n}" }
		sequence(:email)	{ |n| "testuser#{n}@example.com" }
		password	"foobarbar"
		password_confirmation	"foobarbar"

		factory :admin do
			admin true
		end
	end

	factory :article do
		title "title"
		content "content"
		user
	end
end