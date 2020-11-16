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
echo "127.0.0.1 localhost" >> /etc/hosts
echo "deb http://be.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list

cd /opt && mkdir -p /opt/extras && mv banner /opt/extras && mv setmotd /opt/extras

nohup /opt/dgb/bin/digibyted -conf=/opt/digibyte.conf > /dev/null 2>&1 &
/opt/extras/setmotd

exec /usr/sbin/sshd -D
