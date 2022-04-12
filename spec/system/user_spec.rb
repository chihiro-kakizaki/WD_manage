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
        expect(page). to have_content 'メールアドレス が正しくありません。'
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
    end
    context "プロフィールボタンを押した場合" do
      it "自分のプロフィール詳細画面が表示される" do
        visit posts_path
        click_on "プロフィール"
        expect(current_path).to eq user_path(user)
        expect(page).to have_content user.name
      end
    end
  end
end



