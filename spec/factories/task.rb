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
  # factory :third_task, class: Task do
  #   title { '終了期限でソート' }
  #   description { 'テスト確認' }
  #   expired_at { Time.now.since(5.days) }
  #   status { '完了' }
  #   priority { '低' }

  #   after(:build) do |task|
  #     label = create(:third_label)
  #     task.labellings << build(:labelling, task: task, label: label)
  #   end
  # end
end