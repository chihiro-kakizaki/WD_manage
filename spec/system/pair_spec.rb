require 'rails_helper'

RSpec.describe Pair, type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:user_second) {FactoryBot.create(:user_second)}
  before do
    sign_in user
  end
  describe 'ペア作成機能' do
    context 'ペア作成ボタンを押した場合' do
      it 'ペア作成ページに遷移する' do
        visit posts_path
        click_on "ペア作成"
        expect(current_path).to eq new_pair_path
        expect(page).to have_content "ペアを新規作成"
      end
    end
    context '招待する相手のメールアドレスを正しく入力した場合' do
      it 'ペアが作成される' do
        visit new_pair_path
        fill_in "pair_weddingday_on", with: '002022-12-10'
        select '冬', from: "pair_season"
        fill_in "pertner_email", with: user_second[:email]
        click_on "commit"
        expect(page).to have_content user[:name]
        expect(page).to have_content user_second[:name]
      end
    end
    context '既にペア作成されているユーザーやユーザー登録されていないメールアドレスを入力した場合' do
      it 'エラーメッセージが表示される' do
        visit  new_pair_path
        fill_in "pair_weddingday_on", with: '002022-12-10'
        select '冬', from: "pair_season"
        fill_in "pertner_email", with: 'yyyy@gmail.com'
        click_on "commit"
        expect(page).to have_content "メールアドレスが正しくありません"
      end
    end
      context '挙式日が空の状態で新規作成ボタンを押した場合' do
      it 'エラーメッセージが表示される' do
        visit  new_pair_path
        fill_in "pair_weddingday_on", with: ''
        select '冬', from: "pair_season"
        fill_in "pertner_email", with: user_second[:email]
        click_on "commit"
        expect(page).to have_content "挙式日を入力してください"
      end
    end
    context 'ペアの作成が完了した場合' do
      let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
      let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
      let!(:assign2) {FactoryBot.create(:assign, user_id: user_second.id, pair_id: pair.id)}
      it 'デフォルトのTODOリスト一覧が表示される' do
        visit pair_path(pair)
        task_list = pair.default_tasks_params
        expect(task_list[0]).to have_content "衣装"
        expect(task_list.size).to eq  8
      end
    end
  end
  describe 'ペア編集機能' do
    let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
    let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
    let!(:assign2) {FactoryBot.create(:assign, user_id: user_second.id, pair_id: pair.id)}
    let!(:task) {FactoryBot.create(:task, user_id: user_second.id, pair_id: pair.id)}
    before do
      visit pair_path(pair)
    end
    context 'ペア情報を編集ボタンを押した場合' do
      it 'ペア編集ページに遷移する' do
        click_on "ペア情報を編集"
        expect(current_path).to eq edit_pair_path(pair)
        expect(page).to have_content "ペア情報を編集"
      end
    end
    context '元々の挙式日から10日後に挙式日を変更して更新ボタンを押した場合' do
      it '紐づいたタスクの期日目安も10日後にずれて表示される' do
        click_on "ペア情報を編集"
        fill_in "pair_weddingday_on", with: '002022-12-20'
        select '冬', from: "pair_season"
        click_on 'commit'
        expect(page).to have_content '2022-05-20'
      end
    end
    context '挙式日が空の状態で更新ボタンを押した場合' do
      it 'エラーメッセージが表示される' do
        click_on "ペア情報を編集"
        fill_in "pair_weddingday_on", with: ''
        select '冬', from: "pair_season"
        click_on 'commit'
        expect(page).to have_content '挙式日を入力してください'
      end
    end
  end
end
