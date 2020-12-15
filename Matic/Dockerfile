FROM golang:latest

LABEL maintainer="abdul@incubaid.com"
WORKDIR /opt

# User Data to start Node
ENV API_KEY 531bc2e4834e4becac0c08bd3f020d2f
ENV ETH_PRIV_KEY 22092f74b7844a18f081cadb29d1e3e44388d027ee74a1996ef4323273d0b4bb

# Get Dependencies
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
	curl \
        vim \
        tmux \
        net-tools \
        openssh-server \
        iputils-ping \
        git \
        iproute2 \
        dnsutils \
	tree \
	rabbitmq-server \
	build-essential \
        sudo \
        ;

# Get the Binaries for heimdal and bor 
RUN wget --no-check-certificate https://matic-public.s3.amazonaws.com/v0.1.9/matic-heimdall_0.1.9_amd64.deb
RUN wget --no-check-certificate https://matic-public.s3.amazonaws.com/v0.1.8/matic-bor_0.1.8_amd64.deb
RUN dpkg -i matic-*.deb
RUN git clone https://github.com/maticnetwork/public-testnets
RUN git clone https://github.com/vkobel/ethereum-generate-wallet.git

# Set Matic Data Directory
RUN mkdir -pv /matic-data

#Set temporary access
RUN echo "root:tfnow2020" | chpasswd

# Set Matic Configuration
#COPY config/dash.conf /opt
COPY scripts/start_matic.sh /
#COPY scripts/setmotd /opt
#COPY images/banner /opt

# Set Matic Startup Script
ENTRYPOINT ["/start_matic.sh"]
VOLUME /matic-data

# Open P2P & RPC Port
# EXPOSE 9998 9999
