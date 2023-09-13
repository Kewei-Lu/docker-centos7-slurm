#!/bin/bash -e
set -e
set -x
kill -9 $(ps -ef|grep fastchat.serve.controller|grep -v grep|awk '{print $2}')
kill -9 $(ps -ef|grep fastchat.serve.model_worker|grep -v grep|awk '{print $2}')
kill -9 $(ps -ef|grep fastchat.serve.openai_api_server|grep -v grep|awk '{print $2}')