マルチコンテナ by Docker
====

# step 0 gitの使い方

```
git clone git@github.com:h-imaoka/ecs-handson.git
#とりあえずpull してから、ブランチ切り替え
git checkout -b local-docker origin/local-docker
```

# 完成図
![overview](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/local-docker.png)

# コンテナ間通信用ネットワークの作成
`docker network create flask-net`

# dynamo-local コンテナ作成
`docker run -d -p 8001:8000 --network flask-net --name localdynamo cnadiminti/dynamodb-local`

## dynamo-localのshellを確認してみる
http://127.0.0.1:8001/shell

ただし、このアクセスはあくまでもローカルマシンからブラウザで確認するためだけのもの、`docker run`で指定した `-p 8001:8000` は必須ではない。

コンテナ間通信は `network flask-net` 経由となる

# アプリ用 docker imageのビルド
`docker build . -t docker-ho:1.0`

# アプリ用 コンテナ作成
`docker run -itd -p 5001:5000 --network flask-net --name app0 -e FLASK_APP_DYNAMO_HOST="http://localdynamo:8000" docker-ho:1.0`

dynamo-localとコンテナ間通信をするため、 `flask-net` を利用する。
`--name` で指定した名前で コンテナ内から名前解決できる。
これを使って、 local-dynamoのエンドポイントを指定する=環境変数を上書きしている。

# 確認
http://127.0.0.1:5001

# 次へ
後片付け

```sh
docker ps
# コンテナIDを取得して
docker rm -f [コンテナID]
```

ブランチ切り替え
`git checkout -b local-compose origin/local-compose`

https://github.com/h-imaoka/ecs-handson/blob/local-compose/readme.md
