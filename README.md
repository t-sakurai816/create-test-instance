# create-test-instance-for-town

TOWNで使用するテストインスタンスをサクッと建ててサクッとぶっ壊すためのものです。長期使用は（経験不足のため）考えていません。  
`tfenv`を利用しています。brewでインストールしてください
## 使い方

多分.terraform-versionでバージョン固定されているはずなので下記コマンドで有効にする

```
$ tfenv install
```

**どこかにある`.terraform.tfvars`を持ってくる。**

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
$ terraform destroy
```