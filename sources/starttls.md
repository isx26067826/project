# StartTLS

OPENLDAP per defecte no te la seva comunicació encriptada es per aixo que permet un metode de encriptació per fer-lo mes segur,
 aquest metode de seguretat es diu STARTTLS. Aquest metode ens dona encriptació mitjançant certificats. Abans OPENLDAP separa els ports amb la finalitat que un fos comunicació sense encriptar (port 389) i l'altre encriptar (port 636) tot aixo ja esta **deprecated** i STARTTLS permet fer tant conexions xifradas pel mateix port. 


En la configuració del la comunicació slapd 

## Server 

Creacio de la *Certificate Authority (CA)*. Aquest es un certificat es autosignat, esta avalat per si mateix i es el qui donara tot la confiabilitat als certificats que utilitzara slapd o els clients slapd que es volen fer una connexio segura. Aquest pas ha de realitzar un usuari que tingui permisos per guardar en la carpeta */etc/openldap/certs*, aixo es nomes per tindre tot ordenat.

```bash
 openssl req -new -x509 -nodes -out /etc/openldap/cacrt.pem -days 365 -keyout /etc/openldap/cakey.pem
Generating a 2048 bit RSA private key
...................................................................................................................+++
......+++
writing new private key to 'cakey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ES
State or Province Name (full name) []:Barcelona
Locality Name (eg, city) [Default City]:Barcelona
Organization Name (eg, company) [Default Company Ltd]:Escola del treball 
Organizational Unit Name (eg, section) []:Informatica
Common Name (eg, your name or your server's hostname) []:veritat
Email Address []:veritat@edt.org
```

Creacio del certificat del servidor ldap . Fem un Request i també creen la clau del servidor ldap . Aquest clau ha de estar sense password o sigui sense cap mena de protecció ( una practica poca habitual per tant la password ha de estar un lloc que consideren segur, l'opcio per no posar password es *-nodes *). 

```bash
openssl req -new -newkey rsa:2048 -keyout /etc/openldap/certs/ldapserverkey.pem -nodes -out /etc/openldap/certs/ldapservercsr.pem
Generating a 2048 bit RSA private key
...............................................+++
.................+++
writing new private key to 'ldapserverkey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ES
State or Province Name (full name) []:Barcelona
Locality Name (eg, city) [Default City]:Barcelona
Organization Name (eg, company) [Default Company Ltd]:Escola del treball
Organizational Unit Name (eg, section) []:Informatica
Common Name (eg, your name or your server's hostname) []:ldapserver
Email Address []:ldapserver@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

Signen el certificat el servidor slapd amb la CA que troben en la carpeta */etc/openldap/certs* lloc que openldap desa els certificats.

```bash
openssl x509 -CA /etc/openldap/certs/cacrt.pem -CAkey /etc/openldap/certs/cakey.pem -req -in /etc/openldap/certs/ldapservercsr.pem -CAcreateserial -out /etc/openldap/certs/ldapservercert.pem
```

Modificació del fitxer de slapd.conf, en la part de les opcions globals. 

```bash
#SSL certificate file paths
TLSCACertificateFile /etc/openldap/certs/cacrt.pem
TLSCertificateFile /etc/openldap/certs/ldapservercert.pem
TLSCertificateKeyFile /etc/openldap/certs/ldapserverkey.pem
TLSCipherSuite HIGH:MEDIUM:+SSLv2
TLSVerifyClient never
```


|       StartTLS         |                                                          Opcions                                                                       |
| ---------------------- |:--------------------------------------------------------------------------------------------------------------------------------------:|
| TLSCACertificateFile   | Especifica la CA que avalara a tots els certificats que tindra contacte el slapd                                                       |
| TLSCertificateFile     | Especifica el certificat del servidor del slapd         																			      |
| TLSCertificateKeyFile  | Especifica la clau del certificat del servidor slapd, aquest clau privada no pot estar protegida per contrasenya el slapd no el suporta|
| TLSCipherSuite         | Especifica quin es el cifrat que utilitzaren.                                                                                          |
| TLSVerifyClient        | Especifica les verificacions del certificats en una sessió TLS.                           											  |


## Client
Com ha client copiaren tots els certificats que estan relacionats amb la CA per que encripti la comunicació. Per aixo utilitzaren el commanda *docker cp* que en serveix per copiar diferents arxius dins d'un docker cap a un altre entorn.

```bash
docker cp CONTAINER_NAME:/etc/openldap/certs/cacrt.pem /etc/openldap/certs
docker cp CONTAINER_NAME:/etc/openldap/certs/cacrt.srl /etc/openldap/certs
docker cp CONTAINER_NAME:/etc/openldap/certs/cakey.pem /etc/openldap/certs
```

Afegim la ip del servidor LDAP per que ens faci la traducció. Aquest pas el poden estalviar si tots el docker son en la mateix xarxa docker, en aquest cas tots el container fan la traducció sense cap mena de mofificació del fitxer /etc/hosts.

```
echo "IP-LDAPSERVER  ldapserver" >> /etc/hosts
```

Modificació del fitxer de client del ldap

```bash
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

BASE   dc=edt,dc=org
URI     ldap://ldapserver ldaps://ldapserver


TLS_CACERTDIR   /etc/openldap/certs/
TLS_CACERT      /etc/openldap/certs/cacrt.pem

# Turning this off breaks GSSAPI used with krb5 when rdns = false
SASL_NOCANON    on

```

|   Ldap Client  |                                                          Opcions                                                |
| -------------- |:---------------------------------------------------------------------------------------------------------------:|
| BASE           | Especifica quina sera la base DN de totes les operacions del client ldap                                        |
| URI            | Especifica quines seran les URI(s) dels servidors de ldap                                                       |
| TLS_CACERTDIR  | Especifica la ruta del directory que conte els certificats CA. Aquesta opcio ha de estar abans que *TLS_CACERT* |
| TLS_CACERT     | Especifica quin sera el certificat (CA) que avalara tots els altres certificats                                 |


