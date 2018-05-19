# Execució del StartTLS

Per poder executar aquesta prova el client ha de poguer resoldre el nom del servidor ldap per que en aquest cas incloure el StartTLS ( per que el client resolgui
correctament el nom del servidor hen creat un xarxa per que  en aquesta xarxa tots el hosts es coneixen i també en afegit al seu fitxer */etc/hosts* el servidor
ldap amb l'opcio del docker *--add-host* ).

Creació de la xarxa external dins del entorn de docker on el rang de la xarxa sera 172.30.0.0/24 i el gateway sera el 172.30.0.1 (que corresponde al localhost
que executa el docker).


```bash

docker network create --subnet 172.30.0.0/24 --gateway 172.30.0.1 starttls

```

Executen el ldapserver en mode detach ( back-ground). Per veure com he aconseguit que el ldapserver estigui detach 
click [aqui](https://github.com/isx26067826/project/tree/master/sources/options.md). Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/STARTTLS/server/Dockerfile).



```bash

docker run --name ldapserver -h ldapserver --net starttls --add-host=client:172.30.0.3 --ip 172.30.0.2 -d nickdunaway/server-starttls


```

Executen el client en mode interectiu. Per veure el Dockerfile click [aquí](https://github.com/isx26067826/project/blob/master/sources/STARTTLS/client/Dockerfile).


```bash

docker run --name client -h client --net starttls --add-host=ldapserver:172.30.0.2 --ip 172.30.0.3 -it nickdunaway/client-starttls


```


Aquestes dues imatges son el resultat del Dockerfiles i tots els altres fitxer de configuració que teniu a la directori 
[external](https://github.com/isx26067826/project/tree/master/sources/STARTTLS) . Aquestes imatges les he pujat al Docker hub, si vols 
sapiguer com s'he fet aquest push fes click [aquí](https://github.com/isx26067826/project/tree/master/sources/docker-push.md).

# Comprovació dels dockers 

Fem quasevol comanda ldap client amb l'opció *-ZZ*. Hi ha una diferencia entre la *-Z* i *-ZZ*. La primera opció envia el missatge per negociar el StartTLS pero
si no pot fer la negociació seguir el model normal. Pero quan apliquen la segona requerin que sigui obligatoria el StartTLS i sino surtira error.


```bash
[root@client docker]# ldapsearch -x -b 'dc=edt,dc=org' -LLL -s base -ZZ
dn: dc=edt,dc=org
dc: edt
description: Escola del treball de Barcelona
objectClass: dcObject
objectClass: organization
o: edt.org




```

[Tornar al principi](https://github.com/isx26067826/project/blob/master/README.md)
