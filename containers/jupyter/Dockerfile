FROM python:3.9.7-buster
USER root
WORKDIR /home/projects

COPY requirements_init.txt /tmp/requirements_init.txt

RUN pip install --upgrade pip setuptools && \
    pip install -r /tmp/requirements_init.txt

RUN jupyter server extension disable nbclassic