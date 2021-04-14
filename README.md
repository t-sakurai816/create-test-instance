# create-test-instance

テストインスタンスをサクッと建ててサクッとぶっ壊すためのものです。長期使用は（経験不足のため）考えていません。  
`tfenv`を利用しています。brewでインストールしてください

## 作成されるもの

* EC2インスタンス
* EIP

### 詳細

#### EC2

| リソース | 詳細 |
| ---- | ---- |
| AMI | 最新版のAmazonLinux2 |
| インスタンスタイプ | t2.micro |
| セキュリティグループ | 環境変数で指定したもの |
| サブネット | 環境変数で指定したもの |
| AZ | ap-northeast-1d |
| SSH鍵 | 環境変数で指定したもの |
| ストレージ | マグネティック・30GiB |
| Tag. Name | コマンド引数で指定 |

#### EIP

EIPが作成され、作成したEC2インスタンスに適用されます

#### シェルスクリプト

`user_data.sh`でシェルスクリプトが実行されます。  
内容は下記です

* yumのupdate, upgrade
* timezoneをTokyoにする
* crondの再起動
* gitのインストール
* fishシェルのインストール

## 使い方

多分.terraform-versionでバージョン固定されているはずなので下記コマンドで有効にする

```
$ tfenv install
```

初期化する

```
$ terraform init
```

`.terraform.tfvars.sample`をコピーして`terraform.tfvars`という名前にして環境変数を設定します。

### 動作確認

作成(or 変更)されるインスタンスがどのようなものなのかの確認。構文チェックも兼ねている  
インスタンスの名前を指定して確認する（必須）

```
$ terraform plan -var 'instance_name=TEST-sakurai'
```

### 実行

実際に作成する  
インスタンスの名前を指定して実行する（必須）

```
$ terraform apply -var 'instance_name=TEST-sakurai-hoge'
```

### 削除

作成したやつを根こそぎ消します。

```
$ terraform destroy -var 'instance_name=TEST-sakurai-hoge'
```
