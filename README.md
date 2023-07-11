# mlflow
モデル管理


構成
MLflow
mysql
streamlit



.envに記述



# jupyter

## for vscode
拡張機能dev containersで、コンテナ内でvscodeを開く
kernelは推奨された拡張機能を1,2個入れるだけで動いた(コンテナのpython確認済)

作業はここで行う。


# 役に立ちそうな参考
[MLOps](https://qiita.com/c60evaporator/items/e0eb1a0c521d1310d95d)
[MLflow_Docker](https://qiita.com/c60evaporator/items/e1fd57a0263a19b629d1)
[この構成](https://zenn.dev/mamamajohn/articles/616c2b3e2ae24d)




# future work

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

