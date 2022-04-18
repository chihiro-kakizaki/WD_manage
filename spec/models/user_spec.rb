require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context '全て入力した場合' do
      it 'バリデーションに通る' do
        user = User.new(name: '成功テスト', email: 'aaaa@gmail.com', password: '111111', password_confirmation: '111111')
        expect(user).to be_valid
      end
    end
    context '名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: '', email: 'aaaa@gmail.com', password: '111111', password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'テスト', email: '', password: '111111', password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが正しくない形で入力された場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'テスト', email: 'aaaa', password: '111111', password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'テスト', email: 'aaaa@gmail.com', password: '', password_confirmation: '')
        expect(user).not_to be_valid
      end
    end   
    context 'パスワードと確認パスワードが一致しない場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'テスト', email: 'aaaa@gmail.com', password: '111111', password_confirmation: '222222')
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが6文字より少ない場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'テスト', email: 'aaaa@gmail.com', password: '111', password_confirmation: '111')
        expect(user).not_to be_valid
      end
    end
  end
  describe 'アソシエーションテスト' do
    let!(:user) {FactoryBot.create(:user)}
    context 'ユーザーが削除された場合' do
      let!(:post) {FactoryBot.create(:post, user_id: user.id)}
      let!(:favorite) {FactoryBot.create(:favorite, user: user, post: post )}
      it '該当ユーザーのfavoriteデータも削除される' do
        expect { user.destroy }.to change { Favorite.count }.by(-1)
      end
    end
    context 'ユーザーが削除された場合' do
      let!(:post) {FactoryBot.create(:post, user_id: user.id)}      
      it '該当ユーザーのpostデータも削除される' do
        expect { user.destroy }.to change { Post.count }.by(-1)
      end
    end
    context 'ユーザーが削除された場合' do
      let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
      it '該当ユーザーのtaskデータも削除される' do
        #pairがsaveされた時にcreate_default_tasksによりtaskが8個生成される
        expect { user.destroy }.to change { Task.count }.by(-8)
      end
    end
    context 'ユーザーが削除された場合' do
      let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
      it '該当ユーザーのpairデータも削除される' do
        expect { user.destroy }.to change { Pair.count }.by(-1)
      end
    end
    context 'ユーザーが削除された場合' do
      let!(:user_second) {FactoryBot.create(:user_second)}
      let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
      let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
      let!(:assign2) {FactoryBot.create(:assign, user_id: user_second.id, pair_id: pair.id)}
      it '該当ユーザーのassignデータも削除される' do
        #2人ペアなのでどちらか一方のユーザーが削除された時点でassignは-2の結果が期待される
        expect { user.destroy }.to change { Assign.count }.by(-2)
      end
    end
  end
end