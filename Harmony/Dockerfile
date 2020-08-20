# Setup the base image
FROM ubuntu:18.04

LABEL maintainer="abdul@incubaid.com"
WORKDIR /opt

RUN apt-get -y update && apt install curl -y
RUN curl -LO https://harmony.one/hmycli && mv hmycli hmy && chmod a+x hmy
RUN curl -LO https://harmony.one/node.sh && chmod a+x node.sh

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
        psmisc \
        dnsutils \
        libgmp-dev \
        ;

COPY scripts/start_hmy.sh /
ENTRYPOINT ["/start_hmy.sh"]
VOLUME /opt
EXPOSE 9000 6000
