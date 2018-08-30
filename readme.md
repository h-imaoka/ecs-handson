Multi-Container @ local via docker-composer
====

# step 0 gitの使い方

```
git clone git@github.com:h-imaoka/ecs-handson.git
#とりあえずpull してから、ブランチ切り替え
git checkout -b local-compose origin/local-compose
```

# docker-composeで起動してみる
`docker-compose up`
## docker-compose何がいいの？
複数コンテナ構築・設計を1ファイルで管理管轄

- ネットワーク(link)の指定
- 環境変数
- 依存関係(起動順)

docker-composeの用途は非常に幅広く、使いこなせるようになると、ほとんどdockerコマンドは使わなくなります。覚えておいて損はないです。

### このままだと、うまく動きません！ので、調べて直しましょう
結構な確率で `docker-compose up` のみで正常稼働するようです。  
正常に稼働した場合は、`CTRL-C`で止めて、再度 `docker-compose start` してみてください  
失敗した場合は handson コンテナのみ Exit 1 で停止状態となります。

# トラブルシューティング
## どこがダメか調べる
ヒント
- ログ見直す `docker-compose logs handson`
- flask側のコマンドを一旦 /bin/shとかに変えて、起動後すぐに死なないようにして、入って調査する

# 後始末
`docker-conpose down`

# 次
ブランチ切り替え `git checkout -b local-compose-ans origin/local-compose-ans`
