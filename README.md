# ShareTask
ShareTaskはグループ内でメンバーが各自行うタスクを共有し、進捗を全員に見える化することでグループメンバー全体が各個人のタスクの状況を把握することができるwebサービスです。

## URL
https://sharetask.work/
テストユーザーとしてログインすることで簡易的に機能を見ることが可能です。

## 使用技術

#### バックエンド
- Ruby 2.5.3
- Rails 5.2.2
- Docker
- Nginx
- Rspec
- Rubocop
- CircleCI

#### フロントエンド
- SASS
- Bootstrap
- JQuery
- JavaScript

#### インフラ
* AWS
  - VPC
  - EC2
  - RDS
  - ECS
  - ECR
  - S3
  - ElasticCache Redis
  - ALB
  - Route53
* Docker(開発環境及び本番環境)
  - Nginx
  - Rails
* CircleCi
  - masterへのマージ時にECR・ECSに自動デプロイ

## アーキテクチャ図
<img width="921" alt="sharetask-architecture" src="https://user-images.githubusercontent.com/54569800/81570439-8d8a6680-93db-11ea-94e7-30ed6057abf1.png">

## 機能一覧
* ユーザー登録、ログイン機能全般、パスワードを忘れた際のメール配信(SendGrid)
* 使い方のページ
* テストユーザログイン
* ユーザー検索機能(Ransack)
* グループへユーザーを招待する機能、招待時にメールを送信(SendGrid)
* グループのタスク管理機能
* タスクの進捗管理機能
* タスクの進捗状況をグラフで表示(Chart.js)
* 画像アップロード(activestorage)
* 画像アップロード時にプレビュー表示(ajax)
* 投稿画像を非同期に削除(ajax)
* 画像からテキスト抽出(Google Cloud Vision)
* ページネーション(kaminari)

## モックアップ
https://cacoo.com/diagrams/1DSbP7xkw3QuuuWn/E51DE
