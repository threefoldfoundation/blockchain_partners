#!/usr/bin/env bash

mkdir ~/.ssh
mkdir -p /var/run/sshd
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo $pub_key >> ~/.ssh/authorized_keys
chmod 600 /etc/ssh/ssh_host_*
echo $pub_key >> /root/.ssh/authorized_keys
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile
echo "127.0.0.1 localhost" > /etc/hosts

rm -rf ~/.hmy/blskeys/*
/opt/hmy keys generate-bls-keys --count 1 --shard 0
mkdir -pv ~/.hmy/blskeys && mv *.key ~/.hmy/blskeys

if [ -z "${keypass}" ]; then keypass="tfhmy2020"; fi
echo $keypass > ~/.hmy/blskeys/keypass.txt

blskey=`ls ~/.hmy/blskeys/*.key`

if [ -z "${network}" ]; then network="testnet"; fi
nohup /opt/node.sh -S -k ~/.hmy/blskeys/$blskey -p keypass.txt -N $network -T explorer -i 1 > /dev/null 2>&1 &

exec /usr/sbin/sshd -D
