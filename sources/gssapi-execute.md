# Execució Docker 

Creació d'una xarxa docker la qual anomenarem gssapi. En aquesta xarxa crearem els tres containers per que
puguin comunicarse sense cap problema.

```bash

docker network create --subnet 172.50.0.0/24 --gateway 172.50.0.1 gssapi

```

KERBEROS

Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/gssapi/kerberos/Dockerfile).

```bash

docker run --name skerberos -h skerberos.edt.org --net=gssapi --add-host=ldapserver.edt.org:172.50.0.3 --ip 172.50.0.2 -d nickdunaway/kerberos-gssapi

```

LDAP SERVER

Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/gssapi/ldapserver/Dockerfile).

```bash

docker run --name ldapserver -h ldapserver.edt.org --net gssapi --add-host=skerberos.edt.org:172.50.0.2 --ip 172.50.0.3 -d nickdunaway/ldapserver-gssapi

```

CLIENT

Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/gssapi/client/Dockerfile).


```bash

docker run --name client -h client.edt.org --net=gssapi  --add-host=skerberos.edt.org:172.50.0.2 --add-host=ldapserver.edt.org:172.50.0.3 --ip 172.50.0.4 -it nickdunaway/client-gssapi

```


[Tornar al principi](https://github.com/isx26067826/project/blob/master/README.md)





