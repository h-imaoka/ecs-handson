Multi-Container @ local via docker-composer
====

# step 0 gitの使い方

```
git clone git@github.com:h-imaoka/ecs-handson.git
#とりあえずpull してから、ブランチ切り替え
git checkout -b local-compose-ans origin/local-compose-ans
```

# docker-compose の `depends_on`
コンテナの立ち上げ順は面倒を見てくれるが、サービスが readyになったか = dynamo-localがリクエスト受付状態になったかまでは判定していない
dynamo-local が、http:8000 で受けられるようになるまで、待ってあげる必要がある。

# 解法
## 単純に flask側のシェルスクリプトで sleep入れとく
所詮開発環境なんでー
## wait-for-dependencies使う
https://github.com/dadarek/docker-wait-for-dependencies

一見良さそうに見えるが、`depens_onをチェインしても、サービスが完了したかの確定はしていない` ので、今回のケースで使うと、起動成功率50％ぐらいにかならない。
そもそも、READMEにあるように、 `docker-compose up` ですべてうまく行く構想じゃない。依存関係解決用のコンテナを先に上げとく
__要するに、あんまりいみない__
## dockerizerとか、依存するコンテナ側で待つ
結果的にこれ。
dockerizeを利用した。(別にシェルでもOK)
https://github.com/jwilder/dockerize


結構多機能、依存のwaitだけでは無く、テンプレートエンジンを搭載しており、`docker run/start` 時に環境変数とテンプレートを用いて、都度設定ファイルを生成することも可能。  
(似たようなツールは沢山あります。)

# 確認
```
docker build . -t docker-ho:1.1
docker-compose up
```
# 後始末
`docker-conpose down`
