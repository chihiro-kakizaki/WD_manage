FactoryBot.define do
  factory :user, class:User do
    name { 'テストユーザー' }
    email { 'test@gmail.com' }
    password { 'testpassword' }
    password_confirmation {'testpassword'}
    admin { 'false' }

    after(:create) {|user| user.confirm}
  end

  
  factory :user_second, class: User do
    name { 'お試しユーザー' }
    email { 'second@gmail.com' }
    password { '123456' }
    password_confirmation {'123456'}
    admin { 'false' } 

    after(:create) {|user| user.confirm}
  end

  factory :user_third, class: User do
    name { 'ペア未作成ユーザー' }
    email { 'third@gmail.com' }
    password { '123456' }
    password_confirmation {'123456'}
    admin { 'false' } 

    after(:create) {|user| user.confirm}
  end
end