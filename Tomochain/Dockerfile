# Setup the base image
FROM ubuntu:18.04
LABEL maintainer="abdul@incubaid.com"
WORKDIR /opt

# Install dependencies
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        vim \
        net-tools \
        openssh-server \
        iputils-ping \
	iproute2 \
	tmux \
        git \
        make \
	gcc \
	curl \
	tree \
        dnsutils \
        musl-dev \
        ;

#User Variables
ENV IDENTITY ''
ENV PASSWORD ''
ENV PRIVATE_KEY ''
ENV BOOTNODES ''
ENV VERBOSITY 3
ENV NETWORK_ID '88'
ENV WS_SECRET ''
ENV NETSTATS_HOST ''
ENV NETSTATS_PORT ''

COPY scripts/start_tomo.sh /
COPY scripts/banner /opt
COPY scripts/setmotd /opt
COPY config/tomo /opt

#ENTRYPOINT ["/start_tomo.sh"]
EXPOSE 8545 8546 30303 30303/udp
VOLUME /opt
