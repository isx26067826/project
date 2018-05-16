
```bash
docker run --name ldapserver -h ldapserver --net=external -it server
docker run --name client -h client --net=external --add-host=ldapserver:172.50.0.2 -it client /bin/bash
```



