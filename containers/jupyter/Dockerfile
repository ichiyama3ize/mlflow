FROM python:3.9.7-buster
USER root


# env in container
ARG WORKING_DIR
WORKDIR ${WORKING_DIR}

ARG MLFLOW_PORT
ENV MLFLOW_PORT=${MLFLOW_PORT}
ENV PIPENV_VENV_IN_PROJECT=true


# pyenv: for python versions
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc


COPY requirements_init.txt ${WORKING_DIR}/requirements.txt

RUN pip install --upgrade pip setuptools && \
    pip install pipenv && \
    pip install -r ${WORKING_DIR}/requirements.txt

RUN jupyter server extension disable nbclassic