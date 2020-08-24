# Tomochain

### How to build from the Dockerfile ?

```
git clone https://github.com/threefoldfoundation/blockchain_partners.git
cd Tomochain
docker build --tag tomo:latest .
```

Sit back and relax then ! It should be quicker and you should see a successful message as below,

```
Step 13/17 : ENV NETSTATS_PORT ''
 ---> Using cache
 ---> 7f8d60c61c7e
Step 14/17 : COPY scripts/start_tomo.sh /
 ---> Using cache
 ---> c1954b60c2a8
Step 15/17 : COPY config/tomo /opt
 ---> Using cache
 ---> 1350fbb4fe6b
Step 16/17 : EXPOSE 8545 8546 30303 30303/udp
 ---> Running in c1611138db7f
Removing intermediate container c1611138db7f
 ---> 13f4041c7146
Step 17/17 : VOLUME /opt
 ---> Running in d9b4fef858f4
Removing intermediate container d9b4fef858f4
 ---> 1e6d1a3ce0ea
Successfully built 1e6d1a3ce0ea
Successfully tagged tomo:latest
```
