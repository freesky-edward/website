
FROM alpine:latest

MAINTAINER Edward Lee <freesky.edward@gmail.com>

RUN apk add --no-cache \
    curl \
    git \
    openssh-client \
    rsync \
    build-base \
    libc6-compat

ENV HUGO_VERSION=0.56.3

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz && \
    mv hugo /usr/local/bin/ && \
    addgroup -Sg 1000 hugo && \
    adduser -Sg hugo -u 1000 -h /src hugo

COPY . /src/

RUN cd /src/ && /usr/local/bin/hugo

WORKDIR /src

EXPOSE 80

# ENTRYPOINT ["hugo", "server", "--bind","0.0.0.0","-p","1313","--baseURL","http://49.4.95.151/"]
