ECSクラスタで動かす
====

# step 0 gitの使い方

```
#ブランチ切り替え
git checkout -b ecs-service origin/ecs-service
```

# まだなら、CloudFormationでハンズオン用スタックを作成する
CloudFormationの画面から
1. `Create-Stack`
2. ファイルを選択で、 Cfn/master.yamlを選択
3. スタック名は ecs-handsonとか、なんでもOK
4. IAM系の作成してもOK?のチェックボックスをONにする

# 構成概要
![overview](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/ECS-overview.png)

# ECSがやってくれること
![ecsecr](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/ECS-ECR.png)

# タスク定義
## 定義のゴール
![task](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/ECS.png)

## ローカルのDocker Imageを ECRへプッシュ
AWSのIAM認証・権限でDocker push (git/codecommitのクレデンシャルヘルパーと同じ)
なので、 `awscli` と、ECRへの強い権限を持つIAMが必要 = わからなければとりあえずadminロールもつcredentialで！

プッシュまでの方法は、
![push](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS.png)
を参考にしてください、

下記はサンプル
```
# タグを打って
docker tag docker-ho:1.0 xxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:1.0
docker tag docker-ho:1.0 xxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:latest

# pushする
docker push xxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:1.0 xxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:latest
```

## タスク定義の作成

AWS-CLIでもできるようにしました。
`aws ecs register-task-definition --cli-input-json file://shortener-task-definition.json`

![step1](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-2.png)
![push](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-3.png)
![img4](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-4.png)
![docker](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/docker-image.png)
![img5](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-5.png)
![img6](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-6.png)


## サービス定義＆稼働

![img7](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-7.png)
![img8](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-8.png)
![img9](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-9.png)
![img10](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-10.png)
![img11](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-11.png)

## これだと動かないよ！
CloudWatch Logsでエージェントのログを調べてみよう
サービスは、Desire数を維持しようとするので、無限に生まれて死んでを繰り返すから、Desireを0にして、タスク実行で調べよう
SSHはできないので、どうしてもSSHしたいなら、ECSコンテナインスタンスをクローンしよう、鍵付きで

## うまくサービスで動いたら動作確認
http://ALBのエンドポイント/

# バグフィックスしよう
短縮URLのボタンを何回か押すと、Divがどんどん増えるのでそれを治す

## ローカルでテスト (docker-compose)
### 修正版 Docker imageの作成
```
cp app/templates/index.html.bugfixed app/templates/index.html
docker build . -t docker-ho:1.1
```

### docker-composeを修正
わかるだろうから省略
docker imageのタグを変更するだけ

### ローカルで実行
```
docker-compose down
docker-compose up
```
ブラウザから叩いて動作確認

### ECR に push 1.1を
```
docker tag docker-ho:1.1 xxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:1.1
docker tag docker-ho:1.1 xxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:latest
docker push xxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:1.1
docker push xxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-hanson:latest
```

### タスク定義を変更
これもコンテナのタグを書き換えるだけ

### サービスの定義変更
最新のタスク定義に差し替え


# 後始末
cloudformation 親元スタックを delete stackすれば大抵消える。消えないものは手動で

