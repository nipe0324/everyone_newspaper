namespace :db do
  desc "サンプルデータを作成する"
  task populate: :environment do
    make_users
    make_categories
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

def make_categories
  categories = %w[表紙 政治 スポーツ 科学 アート 娯楽 ネット 広告]
  categories.each do |category|
    Category.create!(name: category)
  end
end

def make_articles
  users = User.all
  categories = Category.all

  # 100記事作成
  100.times do |i|
    title = Faker::Lorem.words(3).join
    content = Faker::Lorem.paragraph(10)
    user = users[ rand(users.count) ] # ユーザを無作為に選択
    category = categories[ rand(categories.count) ] # カテゴリを無作為に選択
    # 記事を作成
    user.articles.create!(title: title, content: content, category: category)
  end
end