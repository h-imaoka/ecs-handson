iret向けハードモード
====

# step 0 gitの使い方

```
git clone git@github.com:h-imaoka/ecs-handson.git
#とりあえずpull してから、ブランチ切り替え
git checkout -b ecs-hard-mode origin/ecs-hard-mode
```

# 変更点
nginxを追加して fabiconを nginxで配信、それ以外は flaskへ流す

# 構成図
![overview](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/local-container-hard.png)

## localにて
### タグ 'latest' について
docker-compose.yaml で Docker imageを指定している  
`docker-ho` は `latest` を省略した表記。そのため、`docker-ho:latest` というタグをつける必要がある。

`docker images` で一番若い docker-ho のイメージを探し  
`docker tag docker-ho:1.1 docker-ho:latest`

### nginx のコンテナ build
`docker build . -f Dockerfile-nginx -t nginx-ho:latest`

ここではいきなり latestのタグをつけてビルドしている。

### docker-composeで試す
`docker-compose up`

http:localhost:8080/  
http:localhost:8080/favicon.ico

## Bugfix flaskのコンテナアプリ修正
同じURLで短縮URLを生成すると、そのたびにHTMLが生成されて、デザイン上イケてない。この点を修正する。  
すでに修正済みのファイルを、コピー上書きする

```
cd app/templates
cp index.html.bugfixed index.html
cd ../..
docker build . -t docker-ho:latest
docker-compose down
docker-compose up -d
```

で http://localhost:8080/ アクセスして試してみる。

# ECSにて
ヒント
- nginxは外に晒す = composeと同じ 
- handson と nginx はコンテナ間通信するので、linkの設定が必要
- コンテナはもちろん、ecs-agentのログも cwlogsで確認する
