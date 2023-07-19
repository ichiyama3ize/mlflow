FROM python:3.9.7-buster
USER root

ARG WORKING_DIR
WORKDIR ${WORKING_DIR}

ARG MLFLOW_PORT
ENV MLFLOW_PORT=${MLFLOW_PORT}

COPY requirements_init.txt ${WORKING_DIR}/requirements.txt

RUN pip install --upgrade pip setuptools && \
    pip install pipenv && \
    pip install -r ${WORKING_DIR}/requirements.txt

RUN jupyter server extension disable nbclassic