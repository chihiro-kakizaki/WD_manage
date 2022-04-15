require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    let!(:user) {FactoryBot.create(:user)}
    let!(:user_second) {FactoryBot.create(:user_second)}
    let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
    let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
    let!(:assign2) {FactoryBot.create(:assign, user_id: user_second.id, pair_id: pair.id)}
    before do
      sign_in user
    end
    context 'タスクの新規作成ボタンを押した場合' do
      it 'タスク作成ページに遷移する' do
        visit pair_path(pair)
        click_on "新規作成"
        expect(current_path).to eq new_pair_task_path(pair)
      end
    end
    context 'タスク作成ページで全て入力して作成ボタンを押した場合' do
      it 'タスク一覧作成したタスクが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: "打ち合わせ"
        fill_in "task_description", with: "初回の打ち合わせで担当者と挨拶"
        select '2022', from: "task_expired_on_1i"
        select '7', from: "task_expired_on_2i"
        select '10', from: "task_expired_on_3i"
        select '未着手', from: "task_status"
        click_on "commit"
        expect(current_path).to eq pair_path(pair)
        expect(page).to have_content '打ち合わせ'
      end
    end
    context 'タスク作成ページでタイトルを入力せず作成ボタンを押した場合' do
      it 'タスク一覧作成したタスクが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: "打ち合わせ"
        fill_in "task_description", with: "初回の打ち合わせで担当者と挨拶"
        select '2022', from: "task_expired_on_1i"
        select '7', from: "task_expired_on_2i"
        select '10', from: "task_expired_on_3i"
        select '未着手', from: "task_status"
        click_on "commit"
        expect(current_path).to eq pair_path(pair)
        expect(page).to have_content '打ち合わせ'
      end
    end
    context 'タイトルと詳細を入力せずに作成ボタンを押した場合' do
      it 'バリデーションエラーが発生しエラーメッセージが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: ""
        fill_in "task_description", with: ""
        select '2022', from: "task_expired_on_1i"
        select '7', from: "task_expired_on_2i"
        select '10', from: "task_expired_on_3i"
        select '未着手', from: "task_status"
        click_on "commit"
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "詳細を入力してください"
      end
    end
  end
end