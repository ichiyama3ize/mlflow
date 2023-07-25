FROM python:3.9.7-buster
USER root

# env in container
ARG WORK_DIR
ARG MLFLOW_PORT
ARG DATASET
ARG SDD_DIR

ENV WORK_DIR=${WORK_DIR}
ENV MLFLOW_PORT=${MLFLOW_PORT}
ENV DATASET=${DATASET}
ENV SDD_DIR=${SDD_DIR}

ENV PIPENV_VENV_IN_PROJECT=true

# pyenv: for python versions
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc 

COPY requirements_init.txt ${WORK_DIR}/

RUN pip install --upgrade pip setuptools && \
    pip install --no-cache-dir -r ${WORK_DIR}/requirements_init.txt

RUN jupyter server extension disable nbclassic