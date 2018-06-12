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

## localにて
### nginx のコンテナ build
`docker build . -f Dockerfile-nginx -t nginx-ho:latest`

### docker-composeで試す
`docker-compose up`

http:0.0.0.0:8080/
http:0.0.0.0:8080/favicon.ico

## ECSにて
ヒント
- nginxは外に晒す = composeと同じ 
- handson と nginx はコンテナ間通信するので、linkの設定が必要
- コンテナはもちろん、ecs-agentのログも cwlogsで確認する
