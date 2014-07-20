namespace :db do
  desc "サンプルデータを作成する"
  task populate: :environment do
    password = "foobar"

    # 管理者
    User.create!(name: "admin",
                 email: "admin@example.com",
                 password: password,
                 password_confirmation: password,
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "user#{n+1}@example.com"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end