FactoryGirl.define do
	factory :user do
		name		"testuser"
		email		"testuser@example.com"
		password	"foobarbar"
		password_confirmation	"foobarbar"
	end
end