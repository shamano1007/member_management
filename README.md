# README

別途記載する。  
プロジェクト作成：`rails new member_management -B -d mysql --skip-test`  

# Docker 環境構築
## イメージをpull
`$ docker pull ruby:2.5.1`  
`$ docker pull mysql:5.7`  

## webコンテナに接続
`docker attach web`  

## 初回起動
コンテナ作成  
`$ docker-compose up`  

`webコンテナ`に接続する  

DB作成
`$ rake db:create`  
`$ rake db:migrate`  

## コンテナ起動(初回以降)
`$ docker-compose start`  

## railseサーバー起動
`webコンテナ`に接続する  
`$ rails s -b 0.0.0.0`  
