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

運用上ほぼ必須になるはず、覚えておいて損はない。

### このままだと、うまく動きません！ので、調べて直しましょう

# トラブルシューティング
## どこがダメか調べる
ヒント
- ログ見直す
- flask側のコマンドを一旦 /bin/shとかに変えて、起動後すぐに死なないようにして、入って調査する

# 後始末
`docker-conpose down`
