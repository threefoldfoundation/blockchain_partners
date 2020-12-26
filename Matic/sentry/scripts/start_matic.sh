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
ETH_PRIV_KEY=`heimdalld show-privatekey --home $HEIMDALLDIR | jq .priv_key | tr -d '"'`
ETH_PRIV_KEY=`echo $ETH_PRIV_KEY | tr -d '[:cntrl:]'`
echo "$ETH_PRIV_KEY" >> /tmp/vars.txt

#Matic Configuration Heimdall
CONFIGPATH=/opt/launch/mainnet-v1/sentry/validator
echo "export CONFIGPATH=/opt/launch/mainnet-v1/sentry/validator" >> ~/.bashrc
source ~/.bashrc
cp $CONFIGPATH/heimdall/config/genesis.json  $HEIMDALLDIR/config/genesis.json

sed -i "s/<YOUR_INFURA_KEY>/$API_KEY/g" $HEIMDALLDIR/config/heimdall-config.toml
cd $HEIMDALLDIR/config && heimdallcli generate-validatorkey $ETH_PRIV_KEY
nodeID=`heimdalld tendermint show-node-id`

sed -i "s/.*pex =.*/pex = false/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*moniker =.*/moniker = '$NODE_NAME'/" $HEIMDALLDIR/config/config.toml
sed -i "s/.*seeds =.*/seeds = 'f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656'/" $HEIMDALLDIR/config/config.toml
#sed -i "s/.*max_open_connections =.*/max_open_connections = 100/" $HEIMDALLDIR/config/config.toml
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
mkdir -p $BOR_DIR 
bor --datadir $DATA_DIR init $BORCONFIG/genesis.json
cp $BORCONFIG/static-nodes.json $DATA_DIR/bor/static-nodes.json
cd $DATA_DIR/bor/ && bootnode -genkey nodekey
cd /opt/heimdall && echo "tfnow2020" > password.txt && go run keystore.go $ETH_PRIV_KEY password.txt 2>&1
cp UTC* $DATA_DIR/keystore && cp password.txt $BOR_DIR

ADDRESS=`heimdalld show-account --home $HEIMDALLDIR | jq ".address" | tr -d '"'`
ADDRESS=`echo $ADDRESS | tr -d '[:cntrl:]'`
echo "VALIDATOR_ADDRESS = $ADDRESS" > /etc/matic/metadata
echo "$ADDRESS" >> /tmp/vars.txt

/go/bin/bor --datadir $DATA_DIR --port 30303 --http --http.addr 0.0.0.0 --http.vhosts '*' --http.corsdomain '*' --http.port 8545 --ipcpath $DATA_DIR/bor.ipc --http.api eth,net,web3,txpool,bor --networkid 137 --syncmode full --miner.gaslimit 200000000 --miner.gastarget 20000000 --txpool.nolocals --txpool.accountslots 128 --txpool.globalslots 20000 --txpool.lifetime 0h16m0s --keystore $DATA_DIR/keystore --unlock $ADDRESS --password $BOR_DIR/password.txt --allow-insecure-unlock --nodiscover --maxpeers 1 --metrics --pprof --pprof.port 7071 --pprof.addr 0.0.0.0 --mine --bootnodes "enode://0cb82b395094ee4a2915e9714894627de9ed8498fb881cec6db7c65e8b9a5bd7f2f25cc84e71e89d0947e51c76e85d0847de848c7782b13c0255247a6758178c@44.232.55.71:30303,enode://88116f4295f5a31538ae409e4d44ad40d22e44ee9342869e7d68bdec55b0f83c1530355ce8b41fbec0928a7d75a5745d528450d30aec92066ab6ba1ee351d710@159.203.9.164:30303"

exec /usr/sbin/sshd -D
