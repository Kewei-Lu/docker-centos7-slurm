FROM docker-centos7-slurm:21.08.8
USER root
WORKDIR /workspace

VOLUME ["/var/fastchat"]
RUN ulimit -n 1024000 && yum install -y python3 python3-pip
RUN pip3 install "fschat[model_worker,webui]"
RUN pip3 install --upgrade openai


COPY  start_llm.sh /workspace/
COPY  stop_llm.sh /workspace/
COPY  chat.py /workspace/
RUN chmod 777 /workspace/chat.py
