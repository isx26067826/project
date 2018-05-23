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

Intenten fer un modificació amb un mode simple sense cap mena de protecció i ens donara error

```bash

ldapmodify -x -D "uid=roger,o=becaris,ou=professors,dc=edt,dc=org" -w roger -f modify.ldif

```

El metode GSSAPI té un SSF de 256 el mateix nombre que la directiva update_ssf

```bash

kinit roger/professors.becaris
Password for roger/professors.becaris@EDT.ORG: 


```

Modifiquen amb el metode GSSAPI

```bash

ldapmodify -Y GSSAPI -f modify.ldif 

SASL/GSSAPI authentication started
SASL username: roger/professors.becaris@EDT.ORG
SASL SSF: 256
SASL data security layer installed.
modifying entry "uid=roger,o=becaris,ou=professors,dc=edt,dc=org"


```

[Tornar al principi](https://github.com/isx26067826/project/blob/master/README.md)
