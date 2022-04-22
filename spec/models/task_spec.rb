require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) {FactoryBot.create(:user)}
  let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '', description: '失敗テスト', expired_on: '2022-10-10', status: 0, user: user, pair: pair)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルが150字以上の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: 'a' * 151 , description: '失敗テスト', expired_on: '2022-10-10', status: 0, user: user, pair: pair)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', description:'', expired_on: '2022-10-10', status: 0, user: user, pair: pair )
        expect(task).not_to  be_valid
      end
    end
    context 'タスクの期日目安が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', description:'失敗テスト', expired_on: '', status: 0, user: user, pair: pair )
        expect(task).not_to  be_valid
      end
    end
    context 'タスクのタイトルと詳細が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', description: '成功テスト', expired_on: '2022-10-10', status: 0, user: user, pair: pair)
        expect(task).to be_valid
      end
    end
  end
end
