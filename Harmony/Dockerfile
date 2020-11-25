# Setup the base image
FROM ubuntu:18.04

LABEL maintainer="abdul@incubaid.com"

# Set Digibyte Data Directory
RUN mkdir -pv /hmydata
WORKDIR /opt

# Get me all the Harmony binaries
RUN apt-get -y update && apt install curl -y
RUN curl -LO https://harmony.one/hmycli && mv hmycli hmy && chmod a+x hmy
RUN curl -LO https://harmony.one/node.sh && chmod a+x node.sh
RUN curl -LO https://harmony.one/binary && mv binary harmony && chmod +x harmony

# Install dependencies
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        vim \
	tmux \
        net-tools \
        openssh-server \
        iputils-ping \
        git \
	iproute2 \
        psmisc \
        dnsutils \
        libgmp-dev \
        ;

#Set temporary access
RUN echo "root:tfnow2020" | chpasswd

COPY scripts/start_hmy.sh /
COPY scripts/setmotd /opt
COPY images/banner /opt

ENTRYPOINT ["/start_hmy.sh"]
VOLUME /hmydata
EXPOSE 9000 6000
