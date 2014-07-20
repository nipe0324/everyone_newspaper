namespace :db do
  desc "サンプルデータを作成する"
  task populate: :environment do
    make_users
    make_articles
  end
end

def make_users
  password = "foobar"

  # 管理者
  User.create!(name: "admin",
               email: "admin@example.com",
               password: password,
               password_confirmation: password,
               admin: true)

  # 一般ユーザ
  99.times do |n|
    name  = Faker::Name.name
    email = "user#{n+1}@example.com"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_articles
  users = User.first(6)
  50.times do
    title = Faker::Lorem.words(3).join
    content = Faker::Lorem.paragraph(10)
    users.each { |user| user.articles.create!(title: title, content: content) }
  end
end