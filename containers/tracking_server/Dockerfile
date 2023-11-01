FROM python:3.9.7-buster as builder

# install mlflow and psycopg2
RUN pip install \
    mlflow \
    psycopg2

# main image
# FROM python:3.9.7-slim-buster
# # copy python packages
# COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
# # copy mlflow package
# COPY --from=builder /usr/local/bin/mlflow /usr/local/bin/mlflow
# # copy linux packages for Postgres
# COPY --from=builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
# COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
# # copy gunicorn package
# COPY --from=builder /usr/local/bin/gunicorn /usr/local/bin/gunicorn


# set environment variables
ARG MLFLOW_PORT 
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG DB_HOST
ARG DB_NAME
ARG DEFAULT_ARTIFACT_ROOT
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV DB_HOST=${DB_HOST}
ENV DB_NAME=${DB_NAME}
ENV DEFAULT_ARTIFACT_ROOT=${DEFAULT_ARTIFACT_ROOT}

EXPOSE ${MLFLOW_PORT}

# Start mlflow server
CMD mlflow server \
    --host 0.0.0.0 \
    --port 5001 \
    --backend-store-uri postgresql+psycopg2://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${DB_HOST}:5432/${DB_NAME} \
    --default-artifact-root ${DEFAULT_ARTIFACT_ROOT}

