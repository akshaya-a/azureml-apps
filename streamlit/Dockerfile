FROM python:3.9-slim
LABEL maintainer="Akshaya Annavajhala"

# This is just what the proxy will try to talk to on the compute instance
# It is not necessarily the "published port" or user facing port
ARG TARGET_PORT=8501
ENV TARGET_PORT=${TARGET_PORT}

WORKDIR /server/

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# This is a workaround for CI's broken identity responder inside a custom application.
# Remove this once that is fixed. To use this, you must
# 1. Bind mount ~/.azure (/home/azureuser/.azure)
# 2. set env var HOME=/home/azureuser
# https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt#option-2-step-by-step-installation-instructions
RUN apt-get update && apt-get install curl -y
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

EXPOSE ${TARGET_PORT}

# Make sure MLFLOW_TRACKING_URI is set - older Compute Instances don't have it
# Also ENSURE it is again passed to the Custom Application
CMD python -m streamlit hello --server.enableWebsocketCompression=false
