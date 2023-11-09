# 使い方

1. コンテナを立ち上げる
2. python側でmlflowをインポート
3. mlflow.set_tracking_uri('http://{HOST_IP}:5001')

で実験結果をmlflowに保存できます。厳密にはmlflowは実験を統一的に管理するツールで、数値はDBに、その他の生成物はminIOのストレージに保存されています。

この構成は[公式チュートリアルのscinario3](https://mlflow.org/docs/latest/tracking.html#tracking)が近いです。

また直接url叩いてもGUIで閲覧できます。


# 立ち上げ

立ち上げるために
* .env
* ngrok.yml
の二つを用意する必要があります。

./.env_sampleを参考に**.envを用意**してください。

MOUNT_DB, MOUNT_MINIOはパスを入れてください。

AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEYはminIOが互換性のために用意しているので任意。AWS_BUCKETも作成するバケットの名前なので任意。

NGROK_AUTH_TOKENはngrokにサインインして作ってください。

また、containers/ngrok.sample.ymlを参考に、**ngrok.ymlを作成**してください。
ここの情報がngrokの設定になります。
basic_authは"username:passwd"を任意に決めてください。

## ngrok について
localhostを外部共有するためのもの。[サイトはこちら](https://ngrok.com/)。
使いたくない場合は、docker-compose.ymlのngrokを消せば大丈夫です。
