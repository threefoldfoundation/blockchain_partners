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
rm -f /heimdalld* && mkdir -p /matic-data/.heimdalld && heimdalld init --home $HEIMDALLDIR
echo "export HEIMDALLDIR=/matic-data/heimdalld" >> ~/.bashrc 

#Matic Testnet Configuration - Heimdall
CONFIGPATH=/opt/public-testnets/CS-2008/without-sentry
echo "export CONFIGPATH=/opt/public-testnets/CS-2008/without-sentry" >> ~/.bashrc
source ~/.bashrc
cp $CONFIGPATH/heimdall/config/genesis.json  $HEIMDALLDIR/config/genesis.json
cp $CONFIGPATH/heimdall/config/heimdall-config.toml $HEIMDALLDIR/config/heimdall-config.toml
cp $CONFIGPATH/heimdall/config/config.toml $HEIMDALLDIR/config/config.toml
source ~/.bashrc

sed -i "s/<YOUR_INFURA_KEY>/$API_KEY/g" $HEIMDALLDIR/config/heimdall-config.toml
cd $HEIMDALLDIR/config && heimdallcli generate-validatorkey $ETH_PRIV_KEY
nodeID=`heimdalld tendermint show-node-id`

cp $HEIMDALLDIR/config/config.toml /tmp/
sed -i "s/.*pex =.*/pex = true/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*private_peer_ids =.*/private_peer_ids = '$nodeID'/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*addr_book_strict =.*/addr_book_strict = false/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*persistent_peers =.*/persistent_peers = 'fbeddf0bc0f31aa55fc8d798b426385842c93ac7@18.214.246.244:26656'/" $HEIMDALLDIR/config/config.toml

#Starting Heimdall Services
mkdir $HEIMDALLDIR/logs
heimdalld start --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld.log 2>&1 &
heimdalld rest-server --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld-rest-server.log 2>&1 &
bridge start --all --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld-bridge.log 2>&1 &

#Bor Configuration
BOR_CONFIG=/opt/public-testnets/CS-2008/without-sentry/bor
BOR_DIR=/matic-data/bor
cd $BOR_CONFIG && echo "export BOR_DIR=/matic-data/bor" >> ~/.bashrc
mkdir -p $BOR_DIR/data ## && mkdir -p $BOR_DIR/logs && mkdir -p $BOR_DIR/keystore
cp static-nodes.json genesis.json $BOR_DIR/data 
bor --datadir $BOR_DIR/data init ./genesis.json
cd $BOR_DIR/data/keystore && heimdallcli generate-keystore $ETH_PRIV_KEY && echo "tfnow2020" > $BOR_DIR/password.txt

exec /usr/sbin/sshd -D
