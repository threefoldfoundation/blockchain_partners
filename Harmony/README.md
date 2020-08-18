# Harmony

### How to build from the Dockerfile ?

```
git clone https://github.com/threefoldfoundation/blockchain_partners.git
cd Harmony
docker build --tag hmy:latest .
```

Sit back and relax then ! It should be quicker and you should see a successful message as below,
```
Step 9/11 : ENTRYPOINT ["/start_hmy.sh"]
 ---> Running in 9ced8faf67d2
Removing intermediate container 9ced8faf67d2
 ---> e342505a5f7d
Step 10/11 : VOLUME /opt
 ---> Running in 4e7345d19aa7
Removing intermediate container 4e7345d19aa7
 ---> 2d1c2fe2e513
Step 11/11 : EXPOSE 9000 6000
 ---> Running in 9f0ec25de1df
Removing intermediate container 9f0ec25de1df
 ---> 2f40515c3619
Successfully built 2f40515c3619
Successfully tagged hmy:latest
```

### How to run ?

You can then spin the container with your created image. Map host ports as needed,

```docker run -dit --name=harmony --hostname=harmony -p 9000:9000 -p 6000:6000 hmy:latest bash```
