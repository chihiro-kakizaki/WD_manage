FactoryBot.define do
  factory :testuser, class:User do
    name { 'テストユーザー' }
    email { 'test@gmail.com' }
    password { 'testpassword' }
    password_confirmation {'testpassword'}
    admin { 'false' }

    after(:create) {|user| user.confirm}
  end

  
  # factory :second_user, class: User do
  #   name { '一般' }
  #   email { 'general@gmail.com' }
  #   password { '1111' }
  #   admin { 'false' }  
  # end
end