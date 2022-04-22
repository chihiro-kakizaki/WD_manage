require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) {FactoryBot.create(:user)}
  let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
  let!(:task) {FactoryBot.create(:task, user_id: user.id, pair_id: pair.id)}
  describe 'バリデーションのテスト' do
    context 'コメントが空の場合' do
      it 'バリデーションに引っかかる' do
        comment = Comment.new(content: '', user: user, task: task)
        expect(comment).not_to be_valid
      end
    end
    context 'コメントの内容が100文字以上の場合' do
      it 'バリデーションに引っかかる' do
        comment = Comment.new(content: 'a'* 101, user: user, task: task)
        expect(comment).not_to be_valid
      end
    end
    context 'コメントの内容が1文字以上100文字以下の場合' do
      it 'バリデーションが通る' do
        comment = Comment.new(content: '成功テスト', user: user, task: task)
        expect(comment).to be_valid
      end
    end
  end
end
