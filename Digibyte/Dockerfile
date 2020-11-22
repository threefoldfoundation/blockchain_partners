FROM ubuntu:latest

LABEL maintainer="abdul@incubaid.com"
WORKDIR /opt

# The version of current official release of Digibyte binary
ENV DIGIBYTE=7.17.2

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
        ;

# Get the Binary from github
RUN wget --no-check-certificate https://github.com/digibyte/digibyte/releases/download/v${DIGIBYTE}/digibyte-${DIGIBYTE}-x86_64-linux-gnu.tar.gz
RUN tar -xvzf digibyte-${DIGIBYTE}-x86_64-linux-gnu.tar.gz && rm -f *.tar.gz && mv * dgb

#Set temporary access
RUN echo "root:tfnow2020" | chpasswd

# Set Digibyte Data Directory
RUN mkdir -pv /dgb

# Set Digibyte Configuration
# Create digibyte.conf file
COPY config/digibyte.conf /opt
COPY scripts/start_dgb.sh /
COPY scripts/setmotd /opt
COPY images/banner /opt

# Set Digibyte Startup Script
ENTRYPOINT ["/start_dgb.sh"]
VOLUME /dgb

# Open P2P & RPC Port
EXPOSE 12024 14022
