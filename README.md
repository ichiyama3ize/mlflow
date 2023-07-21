# flow
モデル管理のための環境

# 仕様上の注意
* python 3.8はダメ：jupyter kernelがうまく動かない
* 






# 構成
MLflow
Jupiter (with vscode)
mysql

# jupyter: flow-labコンテナ

コンテナにjupyterlabを立ち上げる
このjupyterコンテナ内にvscode ;dev containerで入る。（初回10分くらい）

この中で自由に作業する。
git cloneして配布されたコードを動かす。
そのために、仮想環境とkernelをjupyterに追加する必要がある。

## パッケージ仮想環境

パッケージ仮想環境 <-(kernel登録)- jupyterサーバー <-(接続)- vscode上のjupyter
実態はコンテナ内に生成。
メタデータも出力し、ローカルにマウント。

仮想環境(.venv)はpipenvによる管理を行いたいため、flow-lab内に入って作成する。
（notebookを通して可能）


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
jupyter kernel uninstall 仮想名
pipenv --rm
クリーンならフォルダごと。


## コマンド実行
時間かかるやつは
jupyter nbconvert --to notebook --output-dir notebooks --execute ファイル名.ipynb
適宜nohup

xxx.test.ipynb      : 小さいデータ等で動作の確認
xxx.ipynb           : .testの入出力を変えた本番。時間のかかるコード。
notebooks/xxx.ipynb : nbconvertで生成された、動作済み（ipynb以外が可能ならそれでconvertする？）





## for local vscode
.ipynbの頭におまじない
%cd $WORK_DIR
%cd 現在のディレクトリを記入

これはローカルvscodeで編集した場合、pwdが動かない問題を解決する。




## ひっかかったところ

### dockerのdownミス
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

### vscodeのjupyter拡張機能の不備(issue)
problem: 使用上の不便さ以外に、挙動が変わりうる。
具体的にはos.getcwd()周辺が意図しない値になりうる。

1. vscode上で.ipynbを作成、編集
2. .ipynbをカレントディレクトリで開けていない
3. $PWDが常にworking_dir
4. dockerの設定ではなく、vscodeのせい。（jupyterで編集したら問題ない）
5. stackOverflowなどの解決通りに設定をいじっても、改善せず。

解決
全ての.ipynbの頭におまじないを付ける
%cd $WORK_DIR
%cd 現在のディレクトリ

現在のディレクトリを.ipynbが知る方法がないため教える必要がある。
この部分を改良したければ解決2へ

解決2 (future work)
pwd(に相当する)コマンドを自作し、裏で動かす。
おなじないを

結論
jupyterは「カーネル」を主な機能として使って、
vscodeはそれを間借りしてるだけ。
なので、.ipynbはまさにnotebookという認識をして、
.ipynb自体が何かのシステムの一部にならないようにする（というか、そもそもそうでしょという話）
そう思えば、vscodeが余計なことをする問題は全く本質的ではないし、共有時にクリティカルなエラーは起きない。


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




