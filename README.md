# mlflow
モデル管理のための環境

# 構成
MLflow
Jupiter (with vscode)
mysql
streamlit

## 設定など

.envに記述



# jupyter

## for vscode
拡張機能dev containersで、コンテナ内でvscodeを開く
kernelは推奨された拡張機能を1,2個入れるだけで動いた(コンテナのpython確認済)

作業はここで行う。

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

## ngrok
現状、mlflowはlocalhostで繋げている。
そのため、保存したartifactsを見せることができない。
これはmlflowのモデルとその成果物（や考察）を一元管理する、


```

```


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

