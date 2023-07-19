# flow
モデル管理のための環境

# 構成
MLflow
Jupiter (with vscode)
mysql


## 設定など
.envに記述



# jupyter

コンテナにjupyterlabを立ち上げる
このjupyterコンテナ内にvscode ;dev containerで入る。（初回10分くらい）

この中で自由に作業する。
git cloneして配布されたコードを動かす。
そのために、仮想環境とkernelをjupyterに追加する必要がある。

## パッケージ仮想環境

パッケージ仮想環境 <-(kernel登録)- jupyterサーバー <-(接続)- vscode上のjupyter
実態はコンテナ内に生成。
メタデータも出力し、ローカルにマウント。

### venv
* 特にインストールが要らない。(pip備え付け)

docker exec -it コンテナ
python -m venv 仮想環境名
source 仮想環境名/bin/activate
pip install ipykernel
ipython kernel install --user --name=仮想環境名

削除は
jupyter kernel uninstall 仮想名

### pipenv
* pythonのverを指定可能
* Pipfileによる必要パッケージの切り分け

cd project
pipenv --python $PYTHON_VERSION
pipenv install ipykernel
ipython kernel install --user --name=仮想名

パッケージ出力
pipenv requirements > requirements.txt

仮想環境の削除
pipenv --rm
クリーンならフォルダごと。


## コマンド実行
時間かかるやつは
jupyter nbconvert --to notebook --output-dir notebooks --execute ファイル名.ipynb
適宜nohup

xxx.test.ipynb      : 小さいデータ等で動作の確認
xxx.ipynb           : .testの入出力を変えた本番。時間のかかるコード。
notebooks/xxx.ipynb : nbconvertで生成された、動作済み（ipynb以外が可能ならそれでconvertする？）





## for vscode

## ひっかかったところ

1. docker内でjupyterのカーネルに"venv"を登録
2. docker削除
3. 再び同じ構成でdocker立ち上げ
4. vscodeでjupyter => "venv"がない

解決
（venvをworkspaseに追加してしまっていた？）
vscode側が設定ファイルを持っている。
ユーザー\AppData\Roaming\Code\User\globalStorage\ms-vscode-remote.remote-containers\imageConfigs\mlflow_jupyter.json
が、ここ以外にもありそう。

結論
dev container内で適当に追加したあとに、そのままコンテナ外に出てdockerをダウンすると危険。

# mlflow

## ui上の操作

Experimentのdelete
=>.trashに移る

modelのdelete
=>

dataset
[mlflow.data](https://mlflow.org/docs/latest/python_api/mlflow.data.html?highlight=delta#mlflow.data.delta_dataset_source.DeltaDatasetSource)
これ以外はartifactとして保存することで、モデルと結びつける
データセットをmlflow形式にできないか？


# 役に立ちそうな参考
[MLOps](https://qiita.com/c60evaporator/items/e0eb1a0c521d1310d95d)
[MLflow_Docker](https://qiita.com/c60evaporator/items/e1fd57a0263a19b629d1)
[この構成](https://zenn.dev/mamamajohn/articles/616c2b3e2ae24d)




# future work

## streamlit

```
  streamlit:
    build:
      context: .
      dockerfile: ./docker/streamlit/Dockerfile
    command: streamlit run struns/main.py
    container_name: ${COMPOSE_PROJECT_NAME}-streamlit
    depends_on: 
      - db
    ports:
      - "8501:8501"
    volumes:
      - "./struns:/usr/src/app/struns"
```

## cookiecutter
projectのひな形を生成する。


## ngrok
現状、mlflowはlocalhostで繋げている。
そのため、保存したartifactsを見せることができない。
これはmlflowのモデルとその成果物（や考察）を一元管理する、




