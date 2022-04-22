require 'rails_helper'

RSpec.describe Favorite, type: :system do
  let!(:user) {FactoryBot.create(:user)}
  before do
    sign_in user
  end
  describe 'お気に入り機能' do
    context 'お気に入りボタンを押したとき' do
      let!(:user_second) {FactoryBot.create(:user_second)}
      let!(:post_third) {FactoryBot.create(:post_third, user_id: user_second.id)}
      it 'お気に入りカウントが1回分増える' do
        visit posts_path

        expect {
                find('.favorite_icon').click
                sleep 0.2
              }.to change { post_third.favorites.count }.by(1)
      end
    end
    context 'お気に入りされている投稿のお気に入り解除ボタンを押したとき' do
      let!(:user_second) {FactoryBot.create(:user_second)}
      let!(:post_third) {FactoryBot.create(:post_third, user_id: user_second.id)}
      let!(:favorite) {FactoryBot.create(:favorite, user_id: user.id, post_id: post_third.id)}
      it 'お気に入りカウントが1回分増える' do
        visit posts_path
        expect {
                find('.notfavorite_icon').click
                sleep 0.2
              }.to change { post_third.favorites.count }.by(-1)
      end
    end
  end
end
