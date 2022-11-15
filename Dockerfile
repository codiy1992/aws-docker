FROM golang:1.17-alpine as ssm-builder

# @link https://github.com/aws/session-manager-plugin/releases
ARG VERSION=1.2.398.0
RUN set -ex && apk update && apk add --no-cache make git gcc libc-dev curl bash zip
RUN curl -skLO https://github.com/aws/session-manager-plugin/archive/${VERSION}.tar.gz
RUN mkdir -p /go/src/github.com && \
    tar xzf ${VERSION}.tar.gz && \
    mv session-manager-plugin-${VERSION} /go/src/github.com/session-manager-plugin && \
    cd /go/src/github.com/session-manager-plugin && \
    make release

FROM alpine:latest

ENV LC_ALL=en_US.UTF-8

USER root

RUN addgroup -S work && adduser -S work -G work -h /home/work

RUN echo 'work   ALL=(ALL)    NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /work

RUN chown -R work.work /home/work

RUN apk update && apk add --no-cache \
        gcc \
        vim \
        bash \
        less \
        sudo \
        curl \
        groff \
        gnupg \
        python3 \
        py3-pip \
        python3-dev \
        bind-tools \
        ca-certificates \
        openssh-client

RUN pip install awscli ansible boto3

# session manager
ARG TARGETARCH
COPY --from=ssm-builder /go/src/github.com/session-manager-plugin/bin/linux_${TARGETARCH}_plugin/session-manager-plugin /usr/bin/

USER work

WORKDIR /work
