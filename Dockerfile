FROM python:3.9-slim
LABEL maintainer="Akshaya Annavajhala"

# This is just what the proxy will try to talk to on the compute instance
# It is not necessarily the "published port" or user facing port
ARG TARGET_PORT=5001
ENV TARGET_PORT=${TARGET_PORT}

WORKDIR /server/

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE ${TARGET_PORT}

# Make sure MLFLOW_TRACKING_URI is set - older Compute Instances don't have it
# Also ENSURE it is again passed to the Custom Application
CMD mlflow server --backend-store-uri ${MLFLOW_TRACKING_URI} --default-artifact-root ${MLFLOW_TRACKING_URI} --host 0.0.0.0 --port ${TARGET_PORT} > server.log 2>&1
