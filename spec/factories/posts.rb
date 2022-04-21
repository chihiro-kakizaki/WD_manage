FactoryBot.define do
  factory :post, class:Post do
    content { '今日は晴れ' }
    #image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/WD_icon.png')) }
    category { :dress }
  end 

  factory :post_second, class:Post do
    content { '二つ目の投稿' }
    category { :flower }
  end

  factory :post_third, class:Post do
    content { 'テスト投稿' }
    category { :flower }
  end

  factory :post_four, class:Post do
    content { 'ペア未作成で挙式季節はナシ' }
    category { :food }
  end
end
  