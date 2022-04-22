require 'rails_helper'

RSpec.describe User, type: :system do

  describe "ユーザー新規登録機能" do
    before do
    ActionMailer::Base.deliveries.clear
    end
    context "全て正しい値を入力し登録ボタンを押した場合" do 
      it "本人確認のメールが送信される" do 
        visit new_user_registration_path
        fill_in "user_name", with:'テスト'
        fill_in "user_email", with: 'aaa@gmail.com'
        fill_in "user_password", with: '123456' 
        fill_in "user_password_confirmation", with: '123456'
        expect {click_on "commit"}.to change { ActionMailer::Base.deliveries.size }.by(1)
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end
    end
    context "すでに登録されているメールアドレスを入力して登録ボタンを押した場合" do
      let!(:user){ FactoryBot.create(:user)}
      it "登録できずエラーが表示される" do
        visit new_user_registration_path
        fill_in "user_name", with:'テストユーザー'
        fill_in "user_email", with: 'test@gmail.com'
        fill_in "user_password", with: '123456' 
        fill_in "user_password_confirmation", with: '123456'
        click_on "commit"
        expect(page). to have_content 'メールアドレスが正しくありません。'
      end
    end
    context "ログインした状態で新規登録ページにアクセスしようとした場合" do
      let!(:user){ FactoryBot.create(:user)}
      it "ポスト一覧ページにリダイレクトされる" do
        visit new_user_session_path
        fill_in "user_email", with: 'test@gmail.com'
        fill_in "user_password", with: 'testpassword'
        click_on "commit"
        expect(current_path).to eq posts_path
        visit new_user_session_path
        expect(current_path).to eq posts_path
      end
    end
  end

  describe "ログインログアウト機能" do
    let!(:user){ FactoryBot.create(:user)}
    before do
      visit new_user_session_path
    end
    context "全て正しい値を入力しログインを押した場合" do
      it "ログインすることできる" do
        fill_in "user_email", with: 'test@gmail.com'
        fill_in "user_password", with: 'testpassword'
        click_on "commit"
        expect(page).to have_content "ログインしました"
      end
    end
    context "誤った値または入力せずログインを押した場合" do
      it "ログインできずにエラーメッセージが表示" do
        fill_in "user_email", with: 'aaaa@gmail.com'
        fill_in "user_password", with: ''
        click_on "commit"
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end
    context "ログアウトボタンを押した場合" do
      it "ログアウトできる" do
        fill_in "user_email", with: 'test@gmail.com'
        fill_in "user_password", with: 'testpassword'
        click_on "commit"
        click_on "ログアウト"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "プロフィール機能" do
    let!(:user){ FactoryBot.create(:user)}
    before do
      sign_in user
      visit posts_path
    end
    context "プロフィールボタンを押した場合" do
      it "自分のプロフィール詳細画面が表示される" do
        click_on "プロフィール"
        expect(current_path).to eq user_path(user)
        expect(page).to have_content user.name
      end
    end
    context "ユーザー情報ボタンを押した場合" do
      it "ユーザー編集ページに遷移する" do
        click_on "プロフィール"
        click_on "ユーザー情報編集"
        expect(page).to have_content "ユーザ編集"
      end
    end
    context "ユーザーネームを変更して更新ボタンを押した場合" do
      it 'ユーザー情報が正しく更新される' do
        click_on "プロフィール"
        click_on "ユーザー情報編集"
        fill_in "user_name", with:'テスト名前変更'
        fill_in "user_email", with: 'test@gmail.com'
        fill_in "user_current_password", with: 'testpassword'
        click_on "commit"
        expect(user.reload.name).to eq 'テスト名前変更'
        expect(page).to have_content 'テスト名前変更'
      end
    end
    context "ユーザーメールアドレスを変更して更新ボタンを押した場合" do
      it '本人確認のメールが送信される' do
        click_on "プロフィール"
        click_on "ユーザー情報編集"
        fill_in "user_name", with:'テストユーザー'
        fill_in "user_email", with: 'aaa@gmail.com'
        fill_in "user_current_password", with: 'testpassword'
        expect {click_on "commit"}.to change { ActionMailer::Base.deliveries.size }.by(1)
        expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'
      end
    end
  end
end



