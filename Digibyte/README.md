# Digibyte

### How to build from the Dockerfile ?

```
git clone https://github.com/threefoldfoundation/blockchain_partners.git
cd Digibyte
docker build --tag hmy:latest .
```
Sit back and relax then ! It should be quicker and you should see a successful message as below,

```
Step 15/17 : ENTRYPOINT ["/start_dgb.sh"]
 ---> Running in 54eb9f2a9231
Removing intermediate container 54eb9f2a9231
 ---> c18a04f7115c
Step 16/17 : VOLUME /digibyte
 ---> Running in 0df5eeed9f6b
Removing intermediate container 0df5eeed9f6b
 ---> d0de06934f0c
Step 17/17 : EXPOSE 12024 14022
 ---> Running in 030f3afef72c
Removing intermediate container 030f3afef72c
 ---> 0781ccba23e2
Successfully built 0781ccba23e2
Successfully tagged dgb:1.1
```
