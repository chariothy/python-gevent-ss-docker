# For Tencent DDNS
# @version 1.0

FROM python:3.8-slim AS compile-env

RUN apt-get update \
    && apt-get install -y build-essential libffi-dev python-dev libevent-dev \
    && apt-get autoclean

COPY requirements.txt .
# Install libs
RUN pip install --no-cache-dir --user -r ./requirements.txt
# 本地编译时需要加国内代理
#RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir -r ./requirements.txt

FROM python:3.8-slim
LABEL maintainer="chariothy@gmail.com"

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL maintainer="chariothy" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.url="https://github.com/chariothy/getmiaoss-docker.git" \
  org.opencontainers.image.source="https://github.com/chariothy/getmiaoss-docker.git" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.vendor="chariothy" \
  org.opencontainers.image.title="getmisass-docker" \
  org.opencontainers.image.description="Docker for getmiaoss" \
  org.opencontainers.image.licenses="MIT"

COPY --from=compile-env /root/.local /root/.local

WORKDIR /usr/src/app

ENV PATH=/root/.local/bin:$PATH
CMD [ "python", "main.py", "sort" ]