#!/bin/bash -e
set -e
set -x
nohup python3 -m fastchat.serve.controller > /var/fastchat/controller.log 2>&1 &
nohup python3 -m fastchat.serve.model_worker --model-path /var/fastchat/Chinese-Alpaca-13B-HF/ --device cpu > /var/fastchat/worker.log 2>&1 &
nohup python3 -m fastchat.serve.openai_api_server --host localhost --port 8000 > /var/fastchat/api_server.log 2>&1 &
