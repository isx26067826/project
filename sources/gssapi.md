# GSSAPI

En aquest metode de autenticació incorporen un altre servidor el kerberos. Aquest proporcionara credenciales per que el servidor ldap pugui fer l'auntenticació del usuari que es vol connectar. Aquest obtindra un ticket-granting i ticket session key emmagatzemat per fer la autenticació.


## Servidor Kerberos

Per implementar aquest servidor kerberos hen utilitzat el realm edt.org aquest sera present en tota la configuració del servidors kerberos i també quan crearen els usuaris.

***/etc/krb5.conf***

```bash

# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 default_realm = EDT.ORG
# default_ccache_name = KEYRING:persistent:%{uid}

[realms]
 EDT.ORG = {
  kdc = skerberos.edt.org
  admin_server = skerberos.edt.org
 }

[domain_realm]
 .edt.org = EDT.ORG
 edt.org = EDT.ORG

```

Establin en el fitxer de configuració del servidor kerberos

***/var/kerberos/krb5kdc/kdc.conf***

```bash

[kdcdefaults]
 kdc_ports = 88
 kdc_tcp_ports = 88

[realms]
 EDT.ORG = {
  #master_key_type = aes256-cts
  acl_file = /var/kerberos/krb5kdc/kadm5.acl
  dict_file = /usr/share/dict/words
  admin_keytab = /var/kerberos/krb5kdc/kadm5.keytab
  supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal
 }

```

***/var/kerberos/krb5kdc/kadm5.acl***

```bash

*/admin@EDT.ORG	*


```

```bash

/usr/sbin/kdb5_util create -P masterkey -s

```

```bash

/usr/sbin/kadmin.local -q "addprinc -pw randkey ldap/ldapserver.edt.org"

```

```bash

admin/admin
pau/alumnes
pere/alumnes
anna/alumnes
marta/alumnes
jordi/alumnes
admin/alumnes
user01/alumnes
user02/alumnes
user03/alumnes
user04/alumnes
user05/alumnes
user06/alumnes
user07/alumnes
user08/alumnes
user09/alumnes
user10/alumnes
marta/professors.tarda
jordi/professors.tarda
anna/professors.mati
marc/professors.mati
robert/professors.tarda
bernat/professors.mati
carme/professors.caps
roger/professors.becaris

```

```bash


#! /bin/bash
#Nick Inga Reynaldo
#Projecte LDAP GSSAPI
#Script que apartir d'un fitxer amb usuaris creara els principals
#en la base de dades de kerberos per que despres la exporten al 
#servidor ldap. 

while read -r line 
do 

	user=$(echo $line)
	password=$(echo $line | cut -f1 -d '/')
	/usr/sbin/kadmin.local -q "addprinc -pw k$password $user"

done < usuaris 



```

```bash

#!/bin/bash
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid $KRB5KDC_ARGS
/usr/sbin/kadmind -nofork -P /var/run/kadmind.pid $KADMIND_ARGS


```

## Servidor LDAP

Parametres que modificarem en slapd.conf per que reconegui la connexió gssapi


```bash
sasl-secprops noanonymous,noplain,noactive
sasl-realm EDT.ORG
sasl-host ldapserver.edt.org

authz-regexp "^uid=[^,/]+/admin,cn=edt\.org,cn=gssapi,cn=auth" "cn=Manager,dc=edt,dc=org"
authz-regexp "^uid=[^,/]+/professors.tarda,cn=edt\.org,cn=gssapi,cn=auth" "uid=$1,o=tarda,ou=professors,dc=edt,dc=org"
authz-regexp "^uid=[^,/]+/professors.mati,cn=edt\.org,cn=gssapi,cn=auth" "uid=$1,o=mati,ou=professors,dc=edt,dc=org"
authz-regexp "^uid=[^,/]+/professors.caps,cn=edt\.org,cn=gssapi,cn=auth" "uid=$1,o=caps,ou=professors,dc=edt,dc=org"
authz-regexp "^uid=[^,/]+/professors.becaris,cn=edt\.org,cn=gssapi,cn=auth" "uid=$1,o=beacaris,ou=professors,dc=edt,dc=org"
authz-regexp "^uid=[^,/]+/alumnes,cn=edt\.org,cn=gssapi,cn=auth" "uid=$1,ou=alumnes,dc=edt,dc=org"

```


|  LDAP SERVER GSSAPI  |                                                          Opcions                                        |
| -------------------- |:-------------------------------------------------------------------------------------------------------:|
| sasl-secprops  	   | Especifica les propietats del Cyrus SASL.(1)															 |
| sasl-realm     	   | Especifica el SASL realm                                            									 |
| sasl-host      	   | Especifica el domini del host on estara la configuracio SASL  											 |
| authz-regexp    	   | Directiva encarregada de fer un traduccion entre els usuaris sasl a usuaris simples de la base de dades |

(1) En aquest cas definin tres opcions en el sasl-secprops : noanonymous (no permet l'autenticació del usuaris anonymous), noplain (protegeix al server de atacs pasius), noactive (protegeix al server de atacs pasius).


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
Configuració habitual on poden veure el tipus de base de dades ( en aquest cas es una bdb), l'arrel del arbre (dc=edt,dc=org), especifica el administrador de la base de dades (cn=Manager,dc=edt,dc=org), on es desara la base de dades (/var/lib/ldap), amb quins atributs estaran fets els index (objectClass eq,pres) i com ha final les ACLs. Un diferencia a la configuració habitual del ldapserver es que la directiva on guarden la contrasenya del administrador de la base de dades rootpw crida al SASL per obtindre la seva contrasenya ({SASL}admin/admin@EDT.ORG), al usuari admin/admin.

El servidor de LDAP tambe tindra que tindra la configuració de kerberos en aquest especificara quin es el servidor kerberos que li proporcionara tiquets . En aquest cas hen utilitzat el *skerberos.edt.org* aquest tambe tendra que estar especificat com ha host coneguts pel sistema en el /etc/hosts o pertany tots els hosts a la mateixa xarxa docker com també ho fem en el exemple.

```bash

# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 default_realm = EDT.ORG
# default_ccache_name = KEYRING:persistent:%{uid}

[realms]
 EDT.ORG = {
  kdc = skerberos.edt.org
  admin_server = skerberos.edt.org
 }

[domain_realm]
 .edt.org = EDT.ORG
 edt.org = EDT.ORG


```

En autenti

```bash

/usr/bin/kadmin -p admin/admin -w kadmin -q "ktadd -k /etc/krb5.keytab ldap/ldapserver.edt.org"
/usr/bin/chown ldap.ldap /etc/krb5.keytab


```

```bash

/usr/sbin/slapd  -d0 -u ldap -h "ldap:/// ldaps:/// ldapi:///"


```













