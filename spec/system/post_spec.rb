require 'rails_helper'


RSpec.describe Post, type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:post) {FactoryBot.create(:post, user_id: user.id)}
  before do
    sign_in user
  end
  describe '新規投稿機能' do
    context '投稿を新規作成した場合' do
      it '作成した投稿内容が投稿一覧に表示される' do
        visit posts_path
        click_on "新しく投稿する"
        fill_in "post_content", with: 'test投稿'
        #attach_file "post_image", "#{Rails.root}/spec/factories/images/WD_icon.png"
        select '衣装', from: "post_category"
        click_on "commit"
        expect(page).to have_content "test投稿"
      end
    end
    
  end
end