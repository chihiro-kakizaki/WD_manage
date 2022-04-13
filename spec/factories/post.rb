FactoryBot.define do
  factory :post, class:Post do
    content { '今日は晴れ' }
    #image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/WD_icon.png')) }
    category { :dress }
  end 

  factory :post_second, class:Post do
    content { '二つ目の投稿' }
    category { :food }
  end

  factory :post_third, class:Post do
    content { '最新の投稿になるはず' }
    category { :flower }
  end
end
  