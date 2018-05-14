# StartTLS

Creacio de la CA. Aquest es un certificat es autosignat, esta avalat per si mateix i es el qui donara tot la confiabilitat als certificats del clients del servidor ldaps.

```bash
 openssl req -new -x509 -nodes -out cacrt.pem -days 365 -keyout cakey.pem
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

Creacio del certificat del servidor ldap . Fem un Request. 

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

signen el certificat

```bash
openssl x509 -CA /etc/openldap/certs/cacrt.pem -CAkey /etc/openldap/certs/cakey.pem -req -in /etc/openldap/certs/ldapservercsr.pem -CAcreateserial -out /etc/openldap/certs/ldapservercert.pem
```

# Server
```bash
#SSL certificate file paths
TLSCACertificateFile /etc/openldap/certs/cacrt.pem
TLSCertificateFile /etc/openldap/certs/ldapservercert.pem
TLSCertificateKeyFile /etc/openldap/certs/ldapserverkey.pem
TLSCipherSuite HIGH:MEDIUM:+SSLv2
TLSVerifyClient never
```

# Client

```bash
docker cp CONTAINER_NAME:/etc/openldap/certs/cacrt.pem /etc/openldap/certs
docker cp CONTAINER_NAME:/etc/openldap/certs/cacrt.srl /etc/openldap/certs
docker cp CONTAINER_NAME:/etc/openldap/certs/cakey.pem /etc/openldap/certs
```



```
echo "172.17.0.2  ldapserver" >> /etc/hosts
```

Modificació del fitxer de client del ldap

```bash
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

#BASE   dc=edt,dc=org
URI     ldap://ldapserver ldaps://ldapserver

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never

TLS_CACERTDIR   /etc/openldap/certs/
TLS_CACERT      /etc/openldap/certs/cacrt.pem

# Turning this off breaks GSSAPI used with krb5 when rdns = false
SASL_NOCANON    on

```
