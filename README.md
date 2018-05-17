# LDAP GSSAPI

## GENERIC SECURITY SERVICE APPLICATION PROGRAM INTERFACE

OPENLDAP és un implementació de software lliure i codi lliure del protocol LDAP (Lightweight Directory Access Protocol). 

Similar al que antigament es coneixia com a una guia telefònica. OPENLDAP es un gestor de base de dades.

### Característiques del OPENLDAP

- Utilitza un base de dades centralitzada.

- Utilitza una estructura jeràrquica mitjançant directoris, els quals poden contenir una gran varietat d'informació
 junta que en altres bases de dades anirien separades (nom, cognom, correu, ip, password, entre altres) i es poden compartir per la xarxa.

- Optimitza les lectures intensiva de dades molt millor que una base de dades relacionals. En aquest cas si les 
dades estan en constant actualització, és molt millor utilitzar una base de dades relacional.

- LDAP utilitza el model client/servidor.

- Una de les principals utilitats que té els directoris de LDAP és com servidor d'autenticació per diferents serveis
 ( com per exemple autenticació per poder entrar a un servidor web, un pc o altre servei).


Aquesta ultima característiques és en la qual es basa el meu projecte. L'autenticació LDAP amb diferents mètodes, 
implementacions i tècniques de criptografia alienes a LDAP.

Per què?

Perquè OPENLDAP per si mateix no cap mena de protecció de les seves dades quan viatgen per la xarxa. Això suposa un risc 
per tota la integritat de la base de dades. Com poden veure en la següent imatge de l'entrada de l'usuari pere en arbre de directori,
 fins i tot per l'usuari root no li permet veure la informació sensible (userPassword, el sistema per defecte encripta la password SSHA )



```bash

dn: uid=pere,ou=alumnes,dc=edt,dc=org
objectclass: posixAccount
objectclass: inetOrgPerson
cn: Pere Pou
sn: Pou
homephone: 555-222-2221
mail: alpere@edt.org
description: Watch out for this guy
ou: alumnes
uid: pere
uidNumber: 5001
gidNumber: 100
homeDirectory: /tmp/home/pere
userPassword: {SSHA}ML0WwodjFjxy7ELs/uGElWYSmjc/qc2j


```

Però, poden dir el mateix de les dades que viatgen per la xarxa. No en la següent imatge veiem com el servidor slapd 
no es preocupa tant per la privacitat de les dades.


![Alt text](https://github.com/isx26067826/project/blob/master/sources/wireshark-simple.jpg "Simple Authentication")



En aquest moment on les lleis es posen cada vegada més exigents amb la privacitat, un SysAdmin ha d'estar especialitzat
 en la seguretat de les dades que administra. No ens podem confiar en què no passarà res si no cap mena de protecció.
  Mai haurien d'escatimar en la seguretat.

![Alt text](https://github.com/isx26067826/project/blob/master/sources/hacker.jpg "LDAP PROBLEM AUTHENTICATION")


En aquest projecte he desenvolupat els següents mètodes d'autenticacions. Cadascun ha presentat els seus desafiaments 
però al final la seva implementació m'ha ajudat a progressar en coneixements. Cadascun d'aquest model té una imatge docker per 
tant de poder comprovar i continuar desenvolupant. 



- [Simple](https://github.com/isx26067826/project/tree/master/sources/simple.md)

- [External](https://github.com/isx26067826/project/tree/master/sources/external.md)

- [GSSAPI](https://github.com/isx26067826/project/tree/master/sources/gssapi.md)

- [StartTLS](https://github.com/isx26067826/project/tree/master/sources/starttls.md)

- [SSF](https://github.com/isx26067826/project/tree/master/sources/ssf.md)


