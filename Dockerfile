# @version 1.0
ARG PYVER
FROM chariothy/python-gevent:${PYVER}
LABEL maintainer="chariothy@gmail.com"

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL maintainer="chariothy" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.url="https://github.com/chariothy/python-gevent-ss-docker.git" \
  org.opencontainers.image.source="https://github.com/chariothy/python-gevent-ss-docker.git" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.vendor="chariothy" \
  org.opencontainers.image.title="python-gevent-ss-docker" \
  org.opencontainers.image.description="Docker with python-gevent-shadowsocks" \
  org.opencontainers.image.licenses="MIT"

RUN apt-get update \
	&& apt-get install -y shadowsocks-libev \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

CMD [ "python" ]