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

User.create!(
  name:  'alice',
  email: 'alice@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'bob',
  email: 'bob@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'しおり',
  email: 'shiori@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'けんじ',
  email: 'kenji@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'はるか',
  email: 'haruka@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'だいすけ',
  email: 'daisuke@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'あかね',
  email: 'akane@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'しょうま',
  email: 'shoma@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'えり',
  email: 'eri@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'れん',
  email: 'ren@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'さおり',
  email: 'saori@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'ゆうた',
  email: 'yuta@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'あい',
  email: 'ai@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )
  
User.create!(
  name:  'しんのすけ',
  email: 'shinnosuke@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'あすか',
  email: 'asuka@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )

User.create!(
  name:  'りょうま',
  email: 'ryoma@gmail.com',
  password: '111111',
  admin: false,
  confirmed_at: Time.now
  )
# 10.times do |i|
# User.create!(
#   name: "テストユーザー#{i + 1}",
#   email: "test#{i + 1}@gmail.com",
#   password: "password",
#   admin: false,
#   confirmed_at: Time.now
#   )
# end

# 10.times do |i|
#   Post.create!(
#     content: "テスト投稿#{i + 1}",
#     category: rand(0..6),
#     user_id: rand(1..11)
#   )
# end