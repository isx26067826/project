# GSSAPI

En aquest metode de autenticació incorporen un altre servidor el kerberos. Aquest proporcionara credenciales per que el servidor ldap pugui fer l'auntenticació del usuari que es vol connectar. Aquest obtindra un ticket-granting i ticket session key emmagatzemat per fer la autenticació.

## Servidor LDAP

```bash

sasl-secprops noanonymous,noplain,noactive
sasl-realm EDT.ORG
sasl-host ldapserver.edt.org

authz-policy from
authz-regexp "^uid=[^,/]+/admin,cn=edt\.org,cn=gssapi,cn=auth" "cn=Manager,dc=edt,dc=org"
authz-regexp "^uid=([^,]+),cn=edt\.org,cn=gssapi,cn=auth" "uid=$1,ou=alumnes,dc=edt,dc=org"

```


|  LDAP SERVER GSSAPI  |                                                          Opcions                                                |
| -------------- |:---------------------------------------------------------------------------------------------------------------:|
| BASE           | Especifica quina sera la base DN de totes les operacions del client ldap                                        |
| URI            | Especifica quines seran les URI(s) dels servidors de ldap                                                       |
| TLS_CACERTDIR  | Especifica la ruta del directory que conte els certificats CA. Aquesta opcio ha de estar abans que *TLS_CACERT* |
| TLS_CACERT     | Especifica quin sera el certificat (CA) que avalara tots els altres certificats                                 |



```bash
database bdb
suffix "dc=edt,dc=org"
rootdn "cn=Manager,dc=edt,dc=org"
rootpw {SASL}admin/admin@EDT.ORG
directory /var/lib/ldap
index objectClass eq,pres
access to *
        by self write
        by * read


```

## Servidor Kerberos





[isx26067826@localhost ldapserver]$ docker network create --subnet 172.50.0.0/24 --gateway 172.50.0.1 gssapi










