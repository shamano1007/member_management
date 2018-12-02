# README

別途記載する。  
プロジェクト作成：`rails new member_management -B -d mysql --skip-test`  

# Docker 環境構築
## イメージをpull
`$ docker pull ruby:2.5.1`  
`$ docker pull mysql:5.7`  

## 初回起動
コンテナ作成  
`$ docker-compose up`  

## コンテナ起動(初回以降)
`$ docker-compose start`  

---
**以降はwebコンテナに接続して実施**
# webコンテナに接続
`docker attach web`  

# DB作成
`$ rake db:create`  
`$ rake db:migrate`  

# 初期データ挿入
`$ rake db:seed_fu`  

# railseサーバー起動
`webコンテナ`に接続する  
`$ rails s -b 0.0.0.0`  

# メモ
## heroku
https://member-management-s.herokuapp.com

## circleci
https://circleci.com/gh/shamano1007/member_management
