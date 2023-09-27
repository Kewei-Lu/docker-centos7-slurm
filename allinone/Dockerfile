FROM docker-centos7-slurm:23.02.5
USER root
WORKDIR /workspace

VOLUME ["/var/fastchat"]
RUN ulimit -n 1024000 && yum --disablerepo=updates install -y python3 python3-pip
RUN pip3 install "fschat[model_worker,webui]" -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install --upgrade openai


COPY  start_llm.sh /workspace/
COPY  stop_llm.sh /workspace/
COPY  chat.py /workspace/
RUN chmod 777 /workspace/chat.py
