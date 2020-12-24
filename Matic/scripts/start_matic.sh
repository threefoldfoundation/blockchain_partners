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

#cd /opt && mkdir -p /opt/extras && mv banner /opt/extras && mv setmotd /opt/extras

#nohup /opt/dash/bin/dashd -conf=/opt/dash.conf > /dev/null 2>&1 &
#/opt/extras/setmotd
/etc/init.d/rabbitmq-server start
HEIMDALLDIR=/matic-data/heimdalld
rm -f /heimdalld* && mkdir -p /matic-data/heimdalld && heimdalld init --home $HEIMDALLDIR
echo "export HEIMDALLDIR=/matic-data/heimdalld" >> ~/.bashrc 

#Matic Configuration Heimdall
CONFIGPATH=/opt/launch/mainnet-v1/sentry/validator
echo "export CONFIGPATH=/opt/launch/mainnet-v1/sentry/validator" >> ~/.bashrc
source ~/.bashrc
cp $CONFIGPATH/heimdall/config/genesis.json  $HEIMDALLDIR/config/genesis.json

sed -i "s/<YOUR_INFURA_KEY>/$API_KEY/g" $HEIMDALLDIR/config/heimdall-config.toml
cd $HEIMDALLDIR/config && heimdallcli generate-validatorkey $ETH_PRIV_KEY
nodeID=`heimdalld tendermint show-node-id`

#sed -i "s/.*pex =.*/pex = true/" $HEIMDALLDIR/config/config.toml
#sed -i "s/.*moniker =.*/moniker = $NODE_NAME/" $HEIMDALLDIR/config/config.toml
#sed -i "s/.*private_peer_ids =.*/private_peer_ids = ''/" $HEIMDALLDIR/config/config.toml
#sed -i "s/.*addr_book_strict =.*/addr_book_strict = false/" $HEIMDALLDIR/config/config.toml
#sed -i "s/.*persistent_peers =.*/persistent_peers = ''/" $HEIMDALLDIR/config/config.toml

#Starting Heimdall Services
mkdir $HEIMDALLDIR/logs
heimdalld start --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld.log 2>&1 &
heimdalld rest-server --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld-rest-server.log 2>&1 &
bridge start --all --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld-bridge.log 2>&1 &

#Matic Configuration Bor
BORCONFIG=/opt/launch/mainnet-v1/sentry/validator/bor
BOR_DIR=/matic-data/bor && DATA_DIR=$BOR_DIR/data
mkdir -p $BOR_DIR #$BOR_DIR/keystore
bor --datadir $DATA_DIR init $BORCONFIG/genesis.json
cp $BORCONFIG/static-nodes.json $DATA_DIR/bor/static-nodes.json
cd $DATA_DIR/bor/ && bootnode -genkey nodekey
cd /opt/heimdall && echo "tfnow2020" > password.txt && go run keystore.go $ETH_PRIV_KEY password.txt
cp UTC* $DATA_DIR/keystore && cp password.txt $BOR_DIR

exec /usr/sbin/sshd -D
