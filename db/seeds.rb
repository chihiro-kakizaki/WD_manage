# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name:  '管理者',
  email: 'admin@gmail.com',
  password: 'password',
  admin: true,
  confirmed_at: Time.now
  )

10.times do |i|
User.create!(
  name: "テストユーザー#{i + 1}",
  email: "test#{i + 1}@gmail.com",
  password: "password",
  admin: false,
  confirmed_at: Time.now
  )
end

10.times do |i|
  Post.create!(
    content: "テスト投稿#{i + 1}",
    category: rand(0..6),
    user_id: rand(1..11)
  )
end