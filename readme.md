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

![step1](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-2.png)
![push](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-3.png)
![push](https://raw.githubusercontent.com/h-imaoka/ecs-handson/images/images/Amazon_ECS-4.png)

## サービス定義＆稼働

# 後始末
cloudformation 親元スタックを delete stackすれば大抵消える。消えないものは手動で

