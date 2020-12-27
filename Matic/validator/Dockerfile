FROM golang:latest

LABEL maintainer="abdul@incubaid.com"
WORKDIR /opt

# User Data to start Node
ENV API_KEY 531bc2e4834e4becac0c08bd3f020d2f
ENV NODE_NAME tf-validator

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
	expect \
        sudo \
	jq \
        ;

# Get the Binaries for heimdal and bor 
RUN wget --no-check-certificate https://matic-public.s3.amazonaws.com/v0.1.9/matic-heimdall_0.1.9_amd64.deb
RUN dpkg -i matic-*.deb
RUN git clone https://github.com/maticnetwork/bor.git
RUN cd bor && make bor-all
RUN git clone https://github.com/maticnetwork/launch.git
RUN git clone https://github.com/maticnetwork/heimdall.git
RUN git clone https://github.com/vkobel/ethereum-generate-wallet.git

# Set Matic Data Directory
RUN mkdir -pv /matic-data

#Set temporary access
RUN echo "root:tfnow2020" | chpasswd

# Set Matic Configuration
COPY scripts/start_matic.sh /
COPY scripts/setmotd /opt
COPY scripts/keystore.go /opt/heimdall
COPY scripts/banner /opt

# Set Matic Startup Script
ENTRYPOINT ["/start_matic.sh"]
VOLUME /matic-data
