# Execució del Server External

Per poder executar aquesta prova el client ha de poguer resoldre el nom del servidor ldap per que en aquest cas incloure el StartTLS ( per que el client resolgui
correctament el nom del servidor hen creat un xarxa per que  en aquesta xarxa tots el hosts es coneixen i també en afegit al seu fitxer */etc/hosts* el servidor
ldap amb l'opcio del docker *--add-host* ).

Creació de la xarxa external dins del entorn de docker on el rang de la xarxa sera 172.60.0.6/24 i el gateway sera el 172.60.0.1 (que corresponde al localhost
que executa el docker).

```bash

docker network create --subnet 172.60.0.0/24 --gateway 172.60.0.1 external

```

Executen el ldapserver en mode detach ( back-ground). Per veure com he aconseguit que el ldapserver estigui detach click [aqui](https://github.com/isx26067826/project/tree/master/sources/options.md).

```bash

docker run --name ldapserver -h ldapserver --net external --add-host=client:172.60.0.3 --ip 172.60.0.2 -d nickdunaway/external-server 

```

Executen el client en mode interectiu.

```bash

docker run --name client -h client --net external  --add-host=ldapserver:172.60.0.2 --ip 172.60.0.3 -it nickdunaway/external-client

```

Aquestes tres imatges son el resultat del Dockerfiles i tots els altres fitxer de configuració que teniu a la directori 
[external](https://github.com/isx26067826/project/tree/master/sources/external) . Aquestes imatges les he pujat al Docker hub, si vols 
sapiguer com s'he fet aquest push fes click [aquí](https://github.com/isx26067826/project/tree/master/sources/docker-push.md)

Cas 1. El usuari marta té un certificat avalat per la CA que coneix el servidor ldap. Per això el resultat es correcte.

```bash

su - marta
Password: 'marta'

ldapwhoami -ZZ
SASL/EXTERNAL authentication started
SASL username: email=marta@edt.org,cn=marta,ou=Barcelona,o=Barcelona,l=Barcelona,st=Barcelona,c=ES
SASL SSF: 0
dn:uid=marta,ou=alumnes,dc=edt,dc=org

```

Cas 2. El usuari pere té un certificat avalat per la CA que coneix el servidor ldap. Pero està caducat el seu certificat si aquest certificat s'hauri utilitzat
en altres dates seria correcte el resultat pero com no es així en aquest cas la resposta es ***your certificate as expired***

```bash

su - pere     
Password: 'pere'

ldapwhoami -ZZ
ldap_start_tls: Connect error (-11)
	additional info: TLS error -12269:SSL peer rejected your certificate as expired.

```

Cas 3. El usuari anna té un certificat avalat per altre CA que el servidor ldap no coneix. Aquest cas es incorrecte per que el servidor no sap qui es per tant en
aquest cas la resposta es ***does not recognize and trust the CA***

```bash

su - anna
Password: 'anna'

ldapwhoami -ZZ
ldap_start_tls: Connect error (-11)
	additional info: TLS error -12195:Peer does not recognize and trust the CA that issued your certificate.

```


[Tornar al principi](https://github.com/isx26067826/project/blob/master/README.md)
