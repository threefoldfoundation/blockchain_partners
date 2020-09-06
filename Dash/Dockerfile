FROM ubuntu:latest

LABEL maintainer="abdul@incubaid.com"
WORKDIR /opt

# The version of current official release of Dash binary
ENV DASH=0.15.0.0

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
        ;

# Get the Binary from github
RUN wget --no-check-certificate https://github.com/dashpay/dash/releases/download/v${DASH}/dashcore-${DASH}-aarch64-linux-gnu.tar.gz
RUN tar -xvzf *.tar.gz && rm -f *.tar.gz && mv * dash

# Set Digibyte Data Directory
RUN mkdir -pv /dash/.dashcore

# Set Digibyte Configuration
# Create digibyte.conf file
COPY config/dash.conf /dash/.dashcore
#COPY scripts/start_dgb.sh /
#COPY scripts/setmotd /opt
#COPY images/banner /opt

# Set Digibyte Startup Script
#ENTRYPOINT ["/start_dgb.sh"]
VOLUME /dash

# Open P2P & RPC Port
EXPOSE 12024 14022
