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
  avatar_base_path = "app/assets/images/avatar"
  avatar_names_for_users = ["Advertisement_of_the_hub.jpg", "Smiley_face.jpg"]

  # 管理者
  User.create!(name: "admin",
               email: "admin@example.com",
               password: password,
               password_confirmation: password,
               avatar: File.new("#{avatar_base_path}/Aussie_Bear_toy_koala.jpg", "r"),
               admin: true)

  # 一般ユーザ
  avatar_paths = [""]
  49.times do |n|
    name  = Faker::Name.name
    email = "user#{n+1}@example.com"
    # 一般ユーザの1,2番目にはアバター画像を設定する
    if n == 0 || n == 1
      User.create!(name: name, email: email, password: password,
        password_confirmation: password,
        avatar: File.new("#{avatar_base_path}/#{avatar_names_for_users[n]}", "r"))
    else
      User.create!(name: name, email: email, password: password, password_confirmation: password)
    end
  end
end

def make_categories
  categories = %w[表紙 政治 スポーツ 科学 アート 娯楽 ネット 広告]
  categories.each do |category|
    Category.create!(name: category)
  end
end

def make_articles
  article_img_base_path = "app/assets/images/picture"
  article_img_names = 
    ["Aldrin_Looks_Back_at_Tranquility_Base.jpg",
     "Cassiopeia_A-_Cassiopeia_A_in_Many_Colors.jpg",
     "Egyptian_Arch_Newry.jpg",
     "Farmland_in_the_vicinity_of_Mt_Sneffels_Ouray_County_Colorado.jpg",
     "The_Strand_Ballinskelligs_Kerry.jpg"]

  users = User.all
  categories = Category.all

  # 100記事作成
  100.times do |i|
    title = Faker::Lorem.words(3).join
    content = Faker::Lorem.paragraph(10)
    # ユーザ 1,2については記事を最低10個ずつ作成
    # それ以外のユーザはランダムで作成
    if i < 10
      user = users[0]
    elsif 10 <= i && i < 20
      user = users[1]
    else
      user = users[ rand(users.count) ] # ユーザを無作為に選択
    end
    category = categories[ rand(categories.count) ] # カテゴリを無作為に選択
    # 記事を作成
    # 最後の記事には写真つきで作成
    if i >= 100 - article_img_names.count
      user.articles.create!(title: title, content: content, category: category,
        picture: File.new("#{article_img_base_path}/#{article_img_names[i-99]}", "r") )
    else
      user.articles.create!(title: title, content: content, category: category)
    end
  end
end