# Presearch

# Dash

To Deploy on Kubernetes, see this link  [Presearch Helm Chart for K8s](helm)

### How to build from the Dockerfile ?

```
git clone https://github.com/threefoldfoundation/blockchain_partners.git
cd Presearch/
docker build --tag myps_image:latest .
```

### How to run ?

You can then spin the container with your created image. Map the web port as you like,

```docker run -dit --name=myps --hostname=myps -p 9999:80 myps_image:latest bash```
 
