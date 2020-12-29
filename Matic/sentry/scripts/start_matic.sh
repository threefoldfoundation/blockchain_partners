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

# Starting Node Services
/etc/init.d/rabbitmq-server start
MATIC_DATA=/matic-data
HEIMDALLDIR=/matic-data/heimdalld
rm -f /heimdalld* && mkdir -p /matic-data/heimdalld && heimdalld init --home $HEIMDALLDIR
echo "export HEIMDALLDIR=/matic-data/heimdalld" >> ~/.bashrc 
echo "export PATH=$PATH:/go/bin" >> ~/.bashrc

#Matic Configuration Heimdall
CONFIGPATH=/opt/launch/mainnet-v1/sentry/sentry
echo "export CONFIGPATH=/opt/launch/mainnet-v1/sentry/sentry" >> ~/.bashrc
source ~/.bashrc
cp $CONFIGPATH/heimdall/config/genesis.json  $HEIMDALLDIR/config/genesis.json
nodeID=`heimdalld tendermint show-node-id`

NODE_NAME="fullnode"
sed -i "s/.*pex =.*/pex = true/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*prometheus =.*/prometheus = true/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*moniker =.*/moniker = '$NODE_NAME'/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*seeds =.*/seeds = 'f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656'/" $HEIMDALLDIR/config/config.toml

#Starting Heimdall Services
mkdir $HEIMDALLDIR/logs
heimdalld start --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld.log 2>&1 &
heimdalld rest-server --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld-rest-server.log 2>&1 &
bridge start --all --home $HEIMDALLDIR > $HEIMDALLDIR/logs/heimdalld-bridge.log 2>&1 &

#Matic Configuration Bor
BORCONFIG=/opt/launch/mainnet-v1/sentry/sentry/bor
BOR_DIR=/matic-data/bor && DATA_DIR=$BOR_DIR/data
mkdir -p $BOR_DIR 
bor --datadir $DATA_DIR init $BORCONFIG/genesis.json
cp $BORCONFIG/static-nodes.json $DATA_DIR/bor/static-nodes.json
cd $DATA_DIR/bor/ && bootnode -genkey nodekey

/go/bin/bor --datadir $DATA_DIR --port 30303 --http --http.addr '0.0.0.0' --http.vhosts '*' --http.corsdomain '*' --http.port 8545 --ipcpath DATA_DIR/bor.ipc --http.api 'eth,net,web3,txpool,bor' --syncmode 'full' --networkid '137' --miner.gaslimit '200000000' --miner.gastarget '20000000' --txpool.nolocals --txpool.accountslots '128' --txpool.globalslots '20000' --txpool.lifetime '0h16m0s' --maxpeers 200 --metrics --pprof --pprof.port 7071 --pprof.addr '0.0.0.0' --bootnodes "enode://0cb82b395094ee4a2915e9714894627de9ed8498fb881cec6db7c65e8b9a5bd7f2f25cc84e71e89d0947e51c76e85d0847de848c7782b13c0255247a6758178c@44.232.55.71:30303,enode://88116f4295f5a31538ae409e4d44ad40d22e44ee9342869e7d68bdec55b0f83c1530355ce8b41fbec0928a7d75a5745d528450d30aec92066ab6ba1ee351d710@159.203.9.164:30303" 2>&1 &

#Preparing Node Info
nodeID=`heimdalld tendermint show-node-id`
enodeID=`/go/bin/bootnode -nodekey $DATA_DIR/bor/nodekey -writeaddress`

cd /opt && mkdir -p /opt/extras && mv banner /opt/extras && mv setmotd /opt/extras
/opt/extras/setmotd $MATIC_DATA $nodeID $enodeID && mv * /opt/extras

exec /usr/sbin/sshd -D
