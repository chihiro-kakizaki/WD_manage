FactoryBot.define do
  factory :task do
    title { 'テストタイトル' }
    description { 'テスト詳細' }
    expired_on { '2022/8/10' }
    status { 0 }
  end
  factory :second_task, class: Task do
    title { '卒業課題' }
    description { 'WD_manage' }
    expired_on { '2022/6/10' }
    status { '1' }
  end
end