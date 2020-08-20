# Setup the base image
FROM ubuntu:18.04

LABEL maintainer="abdul@incubaid.com"
WORKDIR /tomochain

# Install dependencies
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        vim \
        net-tools \
        openssh-server \
        iputils-ping \
        git \
        make \
	gcc \
	curl \
        dnsutils \
        musl-dev \
        ;

COPY scripts/start_hmy.sh /
COPY config/tomo /usr/bin

ENTRYPOINT ["/start_tomo.sh"]
