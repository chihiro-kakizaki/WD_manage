# README

# 開発言語
* Ruby 3.0.1
* Ruby on Rails 6.0.4
* bootstrap 4.5.0
* jQuery 3.5.1

# インフラ
* Heroku
* AWS S3
* SendGrid

# gem
* cancancan
* devise
* enum_help
* kaminari
* rails_admin
* ransack

# 主な機能
* ユーザー機能
  * ユーザー作成/編集/削除
  * ユーザーログイン/ログアウト
  * ゲストユーザー・ゲスト管理者ログイン/ログアウト
* ペア機能
  * ペア招待
  * ペア承認/却下
  * ペア作成/編集/削除
* ペアTODOリスト機能
  * デフォルトTODOリスト自動作成
  * TODOリスト追加作成/編集/削除
* 投稿機能
  * 作成/編集/削除
  * タグ付け
* 検索機能
  * 投稿の検索
* ソート機能
  * TODOリストのソート
* コメント機能
  * 作成/編集/削除
* お気に入り機能
  * 追加/削除
# 実行手順
```
git clone git@github.com:chihiro-kakizaki/WD_manage.git
cd WD_manage
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s
```

# カタログ設計
https://docs.google.com/spreadsheets/d/13911e8qpC9_uVOncJ-E2hhwBQo8DUaPeMp3LcDNoQ6A/edit?usp=sharing>

# テーブル定義
<https://docs.google.com/spreadsheets/d/13XPPxRYvI24yrc7Jftvz3ZtGh6ODa0xg2caZlbieW9k/edit?usp=sharing>

# ER図
https://user-images.githubusercontent.com/97084997/176834597-21f2ccd3-1ff4-497f-b9fe-4b8ec8ce3e42.png

![ER図](<https://user-images.githubusercontent.com/97084997/176834597-21f2ccd3-1ff4-497f-b9fe-4b8ec8ce3e42.png>)
