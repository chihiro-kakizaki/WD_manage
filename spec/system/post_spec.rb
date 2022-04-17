require 'rails_helper'


RSpec.describe Post, type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:post) {FactoryBot.create(:post, user_id: user.id)}
  let!(:post_second) {FactoryBot.create(:post_second, user_id: user.id)}
  let!(:user_second) {FactoryBot.create(:user_second)}
  let!(:post_third) {FactoryBot.create(:post_third, user_id: user_second.id)}
  before do
    sign_in user
  end
  describe '新規投稿機能' do
    context '投稿を新規作成した場合' do
      it '作成した投稿内容が投稿一覧に表示される' do
        visit posts_path
        click_on "新しく投稿する"
        fill_in "post_content", with: 'test投稿'
        #attach_file "post_image", "#{Rails.root}/app/assets/images/WD_icon.png"  
        select '衣装', from: "post_category"
        click_on "commit"
        expect(page).to have_content "test投稿"
      end
    end
  end

  describe '一覧表示機能' do
    context '投稿一覧画面に遷移した場合' do
      before do
        visit posts_path
      end
      it '作成済みの投稿一覧が表示される' do
        expect(page).to have_content '今日は晴れ'
      end
      it '新しいタスクが一番上に表示される' do
        post_list = all('.post_row')
        expect(post_list[0]).to have_content '最新の投稿になるはず'
      end
    end
  end

  describe '投稿編集機能' do
    context '投稿編集ページで投稿を書き換えたとき' do
      it '投稿が更新されて投稿一覧に表示される' do
        visit edit_post_path(post)
        fill_in "post_content", with:'test投稿を更新'
        select '装花', from: "post_category"
        click_on "commit"
        expect(current_path).to eq posts_path
        expect(page).to have_content "test投稿を更新"
        expect(page).to have_content "装花"
      end
    end
      context '自分以外の投稿編集ページに遷移しようとした場合' do
      it '投稿一覧ページにリダイレクトしエラーメッセージが表示される' do
        visit edit_post_path(post_third)
        expect(current_path).to eq posts_path
        expect(page).to have_content "編集できません"
      end
    end
  end

  describe '投稿検索機能' do
    before do
      visit posts_path
    end
    context 'ポスト名が空欄でカテゴリーのみ指定し検索した場合' do
      it 'カテゴリーが一致する投稿一覧が検索結果に表示される' do
        fill_in "q_content_cont", with: ""
        select '装花', from: "q_category_eq"
        click_on "commit"
        expect(page).to have_content "最新の投稿になるはず"
        expect(page).to have_content "二つ目の投稿"
      end
    end
    context 'ポスト名とカテゴリーを指定し検索した場合' do
      it '投稿内容、カテゴリーが一致する投稿一覧が検索結果に表示される' do
        fill_in "q_content_cont", with: "今日は"
        select '衣装', from: "q_category_eq"
        click_on "commit"
        expect(page).to have_content "今日は晴れ"
        expect(page).to have_content "衣装"
      end
    end 
  end  
end