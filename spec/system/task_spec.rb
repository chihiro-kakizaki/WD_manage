require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:user_second) {FactoryBot.create(:user_second)}
  let!(:pair) {FactoryBot.create(:pair, owner_id: user.id )}
  let!(:assign) {FactoryBot.create(:assign, user_id: user.id, pair_id: pair.id)}
  let!(:assign2) {FactoryBot.create(:assign, user_id: user_second.id, pair_id: pair.id)}
  let!(:task) {FactoryBot.create(:task, user_id: user_second.id, pair_id: pair.id)}
  let!(:task_second) {FactoryBot.create(:task_second, user_id: user_second.id, pair_id: pair.id)}
  before do
    sign_in user
  end
  describe '新規作成機能' do
    context 'タスクの新規作成ボタンを押した場合' do
      it 'タスク作成ページに遷移する' do
        visit pair_path(pair)
        click_on "タスク新規作成"
        expect(current_path).to eq new_pair_task_path(pair)
      end
    end
    context 'タスク作成ページで全て入力して作成ボタンを押した場合' do
      it 'タスク一覧作成したタスクが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: "打ち合わせ"
        fill_in "task_description", with: "初回の打ち合わせで担当者と挨拶"
        fill_in "task_expired_on", with: '002022-07-10'
        select '未着手', from: "task_status"
        click_on "commit"
        expect(current_path).to eq pair_path(pair)
        expect(page).to have_content '打ち合わせ'
      end
    end
    context 'タスク作成ページでタイトルを入力せず作成ボタンを押した場合' do
      it 'タスク一覧作成したタスクが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: ""
        fill_in "task_description", with: "初回の打ち合わせで担当者と挨拶"
        fill_in "task_expired_on", with: '002022-07-10'
        select '未着手', from: "task_status"
        click_on "commit"
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
    context 'タイトルと詳細を入力せずに作成ボタンを押した場合' do
      it 'バリデーションエラーが発生しエラーメッセージが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: ""
        fill_in "task_description", with: ""
        fill_in "task_expired_on", with: '002022-07-10'
        select '未着手', from: "task_status"
        click_on "commit"
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "詳細を入力してください"
      end
    end
    context '期日目安を入力せずに作成ボタンを押した場合' do
      it 'バリデーションエラーが発生しエラーメッセージが表示される' do
        visit new_pair_task_path(pair)
        fill_in "task_title", with: "タイトル"
        fill_in "task_description", with: "詳細"
        fill_in "task_expired_on", with: ''
        select '未着手', from: "task_status"
        click_on "commit"
        expect(page).to have_content "期日目安を入力してください"
      end
    end
  end

  describe '一覧表示機能' do
    context 'タスク一覧画面ボタンを押した場合' do
      it 'ペア詳細ページに遷移する' do
        visit posts_path
        click_on "タスク一覧"
        expect(current_path).to eq pair_path(pair)
      end
    end
    context 'ペア詳細ページに遷移した場合' do
      it 'ペア詳細情報が表示される' do
        visit pair_path(pair)
        expect(page).to have_content "TODOリスト"
        expect(page).to have_content user.name
        expect(page).to have_content user_second.name
      end
    end
    context 'ペア詳細ページに遷移した場合' do
      it 'タスク一覧が作成した日時の降順で表示される' do
        visit pair_path(pair)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "衣装"
        expect(task_list.last).to have_content "卒業課題"
      end
    end
    context '期限目安順に並び替えボタンを押した場合' do
      it '期限目安が早いタスクが一番上に表示される', :retry => 3  do 
        visit pair_path(pair)
        click_on "期日目安順に並び替え"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "テストタイトル"
      end
    end
    context '進行度順に並び替えボタンを押した場合' do
      it '進行度が遅いタスクが一番上に表示される', :retry => 3 do
        visit pair_path(pair)
        click_on "進行状況順に並び替え"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "衣装"
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスクの詳細ボタンを押した場合' do
      it '該当タスクの内容が表示される' do
        visit pair_path(pair)
        all("tbody tr")[1].click_on "詳細"
        expect(page).to have_content "衣装"
      end
    end
  end

  describe 'コメント機能' do
    context 'タスク詳細ページでコメントを投稿した場合' do
      it 'タスク詳細ページに投稿したコメントが表示される' do
        visit pair_path(pair)
        all("tbody tr")[1].click_on "詳細"
        fill_in 'comment_content', with:'コメント登録'
        click_on 'commit'
        expect(page).to have_content 'コメント登録'
      end
    end
    # context 'タスク詳細ページでコメントを投稿した場合' do
    #   let!(:comment) {FactoryBot.create(:comment, user_id: user.id, task_id: task.id)}
    #   it 'タスク詳細ページに投稿したコメントが表示される' do
    #     visit pair_task_path(pair,task)
    #     find('.comment_edit').click
    #     sleep 0.3
    #     fill_in 'comment_content_#{task.id}', with:'コメント登録'
    #     click_on 'commit'
    #     expect(page).to have_content 'コメント登録'
    #   end
    # end
  end

  describe '編集機能' do
    before do
      visit pair_path(pair)
    end
    context '任意のタスクの編集ボタンを押した場合' do
      it '該当タスクの編集ページに遷移する' do
        all("tbody tr").last.click_on "編集"
        expect(current_path).to eq edit_pair_task_path(pair,task_second)
      end
    end
    context  '編集内容を入力して更新ボタンを押した場合' do
      it '更新されたタスクがタスク一覧に表示される' do
        all("tbody tr").last.click_on "編集"
        fill_in "task_title", with:"変更したよ"
        fill_in "task_description", with:"変更した内容"
        click_on "commit"
        expect(current_path).to eq pair_path(pair)
        expect(page).to have_content "変更したよ"
      end
    end
  end

  describe '削除機能' do
    before do
      visit pair_path(pair)
    end
    context '任意のタスクの削除ボタンを押した場合' do
      it '該当タスクが削除される' do
        task_list = all('.task_row')
        expect(task_list.size).to eq 10
        all("tbody tr").last.click_on "削除"
        task_list = all('.task_row')
        expect(task_list.size).to  eq 9
      end
    end
  end
end