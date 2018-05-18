

```bash
[isx26067826@i16 server]$ docker network create --subnet 172.30.0.0/24 --gateway 172.30.0.1 starttls
```




```bash

[isx26067826@i16 server]$ docker run --name ldapserver -h ldapserver --net starttls --add-host=client:172.30.0.3 --ip 172.30.0.2 -d server


```







```bash
[isx26067826@i16 server]$ docker run --name client -h client --net starttls --add-host=ldapserver:172.30.0.2 --ip 172.30.0.3 -it client


```









```bash
[root@client docker]# ldapsearch -x -b 'dc=edt,dc=org' -LLL -s base -ZZ
dn: dc=edt,dc=org
dc: edt
description: Escola del treball de Barcelona
objectClass: dcObject
objectClass: organization
o: edt.org




```

