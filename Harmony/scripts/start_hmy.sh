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

if [ -z "${shard}" ]; then shard=0; fi
DATA_DIR=/hmydata
mkdir -pv $DATA_DIR/keys
KEYS_DIR=$DATA_DIR/keys

touch $KEYS_DIR/keypass.txt
if [ -z "${keypass}" ]; then keypass="tfhmy2020"; fi
echo $keypass > $KEYS_DIR/keypass.txt

if [ -z "${blskeycount}" ]; then blskeycount=1; fi

mv /opt/hmy $DATA_DIR
$DATA_DIR/hmy keys generate-bls-keys --count $blskeycount --shard $shard --passphrase-file $KEYS_DIR/keypass.txt
mv *.key $KEYS_DIR

if [ -z "${network}" ]; then network="mainnet"; fi
cd /opt && mkdir -p /opt/extras && mv banner /opt/extras && mv setmotd /opt/extras

mv /opt/harmony $DATA_DIR
nohup $DATA_DIR/harmony --network $network --bls.dir $KEYS_DIR --bls.pass.file $KEYS_DIR/keypass.txt --datadir $DATA_DIR > /dev/null 2>&1 &
/opt/extras/setmotd $shard $network $blskeycount 

exec /usr/sbin/sshd -D
