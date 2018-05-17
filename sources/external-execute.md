# Execució del Server External

Crearem un red docker per que el servidor i el docker es puguin comunicar sense moltes dificultats

```bash
docker network create --subnet 172.60.0.0/24 --gateway 172.60.0.1 external

```


```bash

docker run --name ldapserver -h ldapserver --net external --add-host=client:172.60.0.3 --ip 172.60.0.2 -d server 

```


```bash

docker run --name client -h client --net external  --add-host=ldapserver:172.60.0.2 --ip 172.60.0.3 -it client

```
