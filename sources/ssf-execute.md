# Execució del SSF

Creació d'una xarxa docker la qual anomenarem gssapi. En aquesta xarxa crearem els tres containers per que
puguin comunicarse sense cap problema.


```bash

docker network create --subnet 172.70.0.0/24 --gateway 172.70.0.1 ssf

```

KERBEROS

Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/ssf/kerberos/Dockerfile).


```bash

docker run --name skerberos -h skerberos.edt.org --net=ssf --add-host=ldapserver.edt.org:172.70.0.3 --ip 172.70.0.2 -d nickdunaway/ssf-kerberos 

```

LDAP SERVER

Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/ssf/ldapserver/Dockerfile).


```bash

docker run --name ldapserver -h ldapserver.edt.org --net ssf --add-host=skerberos.edt.org:172.70.0.2 --ip 172.70.0.3 -d nickdunaway/ssf-ldapserver

```

CLIENT

Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/ssf/client/Dockerfile).


```bash

docker run --name client -h client.edt.org --net=ssf  --add-host=skerberos.edt.org:172.70.0.2 --add-host=ldapserver.edt.org:172.70.0.3 --ip 172.70.0.4 -it nickdunaway/ssf-client

```


[Tornar al principi](https://github.com/isx26067826/project/blob/master/README.md)
