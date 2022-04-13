FactoryBot.define do
  factory :post, class:Post do
    content { '今日は晴れ' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/WD_icon.png')) }
    category { :dress }
  end
end
  
#   factory :tesutuser_second, class: User do
#     name { 'お試しユーザー' }
#     email { 'second@gmail.com' }
#     password { '123456' }
#     password_confirmation {'123456'}
#     admin { 'false' }  
#   end
# end