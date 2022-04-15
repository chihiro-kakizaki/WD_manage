FactoryBot.define do
  factory :task do
    title { 'テストタイトル' }
    description { 'テスト詳細' }
    expired_on { '2022/5/10' }
    status { :not_started }
  end
  factory :task_second, class: Task do
    title { '卒業課題' }
    description { 'WD_manage' }
    expired_on { '2022/6/10' }
    status { :start }
  end
end