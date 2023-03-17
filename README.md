### tasksテーブル  
|  Task  |        |  
|  ----  |  ----  |  
| Column |  Type  |  
|  name  | string |  
| content| string |  



- heroku create
- Gemfileに以下のgemを追加しbundle install
- gem 'net-smtp'
- gem 'net-imap'
- gem 'net-pop
- git add .
- git commit -m"init"
- heroku stack:set heroku-20コマンドでバージョンの変更
- git push heroku step2:master
- *heroku run rails db:migrateコマンドでマイグレーション
- *heroku openコマンドでアプリケーションにアクセス

