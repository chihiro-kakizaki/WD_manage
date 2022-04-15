require 'rails_helper'


RSpec.describe Pair, type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:user_second) {FactoryBot.create(:user_second)}
  before do
    sign_in user
  end
  describe 'ペア作成機能' do
    context 'タスク作成ボタンを押した場合' do
      it 'ペア作成ページに遷移する' do
        visit posts_path
        click_on "タスク作成"
        expect(current_path).to eq new_pair_path
        expect(page).to have_content "挙式情報や招待するお相手を入力してTODOリストを作りましょう"
      end
    end
    context '招待する相手のメールアドレスを正しく入力した場合' do
      it 'ペアが作成される' do
        visit new_pair_path
        select '2022', from: "pair_weddingday_on_1i"
        select '12', from: "pair_weddingday_on_2i"
        select '10', from: "pair_weddingday_on_3i"
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
        select '2022', from: "pair_weddingday_on_1i"
        select '12', from: "pair_weddingday_on_2i"
        select '10', from: "pair_weddingday_on_3i"
        select '冬', from: "pair_season"
        fill_in "pertner_email", with: 'yyyy@gmail.com'
        click_on "commit"
        expect(page).to have_content "メールアドレスが正しくありません"
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
end
