FactoryBot.define do
  factory :task do
    title { 'テストタイトル' }
    description { 'テスト詳細' }
    expired_on { Time.now }
    status { 0 }
  end
  factory :second_task, class: Task do
    title { '卒業課題' }
    description { 'WD_manage' }
    expired_on { Time.now.since(3.days) }
    status { '1' }
  end
end