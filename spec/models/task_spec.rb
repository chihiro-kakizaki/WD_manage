require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) {FactoryBot.create(:user)}
  let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
  let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '', description: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルが150字以上の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: 'a' * 151 , description: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', description:'')
        expect(task).not_to  be_valid
      end
    end
    context 'タスクのタイトルと詳細が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', description: '成功テスト', user: user, pair: pair)
        expect(task).to be_valid
      end
    end
  end
end
