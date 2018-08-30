ECS-handson
====

# 今回作るもの
元ソースはこちら
https://github.com/pynamodb/PynamoDB/tree/master/examples/url_shortener

これを コンテナ化して

- ローカルPCのDockerで動かす
- AWS上のECSで動かす

# 事前準備
## `docker` コマンドが通る
```
docker ps

接続できないとかエラーが出ないこと
```

## `aws` コマンドが使えて、自分のアカウントのcredentialが仕込まれている
```
aws s3 ls


自分のS3バケットが見える
```

## うまく動かない人は
いろいろはいったAMIを用意しておくので、ローカルでの作業をEC2でやりましょう。
`ami-0dd817395062d54ca`

- SSHが必要
- SG設定としては下記を開ける
  - 22 (ssh)
  - 8000-8010 (dynamo-local)
  - 5000-5010 (flask)
- 1台でOK

# ECS環境構築
時間がかかるので、CloudFromationでサクッと構築。
内容は後で説明します。


# アプリケーションをローカルで動かす (時間があれば)
![overview](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/local.png)
開始まで時間が余っている人向け！

## ひつようなもの
- docker
- python 2.7 or 3
- pip (python)

## DynamoLocalのコンテナを動かす
```
docker pull cnadiminti/dynamodb-local
docker run -d -p 8000:8000 cnadiminti/dynamodb-local
```

shell へアクセスできるか調べる
http://localhost:8000/shell

## パッケージインストール
`pip install -r requrements.txt`

## 動かす
`python shortener.py`

http://localhost:5000

# 次へ

`git checkout -b local-docker origin/local-docker`
