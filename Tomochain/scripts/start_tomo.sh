#!/usr/bin/env bash

mkdir ~/.ssh
mkdir -p /var/run/sshd
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 600 /etc/ssh/ssh_host_*
echo $pub_key >> /root/.ssh/authorized_keys
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile
echo "127.0.0.1 localhost" > /etc/hosts
echo "deb http://be.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list

BASE_DIR=/tomodata

mkdir -pv $BASE_DIR/data && mkdir -pv $BASE_DIR/keys
DATA_DIR=$BASE_DIR/data
KEYSTORE_DIR=$BASE_DIR/keys

touch $KEYSTORE_DIR/pass.txt
if [ -z "${KEYPASS}" ]; then KEYPASS="tf2020"; fi
echo ${KEYPASS} > $KEYSTORE_DIR/pass.txt

if [ -z "${IDENTITY}" ]; then IDENTITY="tf-tomo"; fi
if [ -z "${BOOTNODES}" ]; then BOOTNODES=enode://97f0ca95a653e3c44d5df2674e19e9324ea4bf4d47a46b1d8560f3ed4ea328f725acec3fcfcb37eb11706cf07da669e9688b091f1543f89b2425700a68bc8876@3.212.20.0:30301; fi

if [ -z "${NETWORK_ID}" ]; then NETWORK_ID=88; fi

# Set TomoChain Stats Server | Default
NETSTATS_HOST='wss://stats.tomochain.com'
NETSTATS_PORT='443'
WS_SECRET='getty-site-pablo-auger-room-sos-blair-shin-whiz-delhi'

cd /opt && mkdir -p /opt/extras && mv banner /opt/extras && mv setmotd /opt/extras

# Setup New TomoChain Account and start Full Node
/opt/tomo account new --password $KEYSTORE_DIR/pass.txt --keystore $KEYSTORE_DIR

nohup /opt/tomo --syncmode "full" --announce-txs --datadir $DATA_DIR --networkid $NETWORK_ID --port 30303 --keystore $KEYSTORE_DIR --password $KEYSTORE_DIR/pass.txt --identity $IDENTITY --mine --gasprice 250000000 --bootnodes $BOOTNODES --ethstats $IDENTITY:$WS_SECRET@$NETSTATS_HOST:$NETSTATS_PORT > /dev/null 2>&1 &

/opt/extras/setmotd $DATA_DIR $KEYSTORE_DIR $NETWORK_ID $IDENTITY

exec /usr/sbin/sshd -D
