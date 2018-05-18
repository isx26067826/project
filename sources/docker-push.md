
```bash
docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: nickdunaway
Password: 
Login Succeeded

```



```bash

docker build -t "external-server" .
docker tag external-server docker.io/nickdunaway/external-server
docker push docker.io/nickdunaway/external-server

```

```bash

docker build -t "external-client" .
docker tag external-client docker.io/nickdunaway/external-client
docker push docker.io/nickdunaway/external-client

```
