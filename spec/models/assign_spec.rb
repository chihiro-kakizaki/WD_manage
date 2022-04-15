require 'rails_helper'

RSpec.describe Assign, type: :model do
  let!(:user) {FactoryBot.create(:user)}
  let!(:user_second) {FactoryBot.create(:user_second)}
  let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
  let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
  let!(:assign2) {FactoryBot.create(:assign, user_id: user_second.id, pair_id: pair.id)}
  describe 'アソシエーションテスト' do
    context 'ユーザーが削除されたとき' do
      it '該当ユーザーのassignデータも削除される' do
        expect { user.destroy }.to change { Assign.count }.by(-2)
      end
    end        
  end
end