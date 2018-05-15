# EXTERNAL

Aquest metode de autenticació utilitza un certificat avalta per una CA i correcte per poguer estableixa conexions segures i confiables amb el servidor ldap.

## Client 

### Creació de certificat del client.


Per poguer fer aquest certficat necesitaren que alguna algun *Certificate Authority* que avali. Sera el mateix que avala el del servidor de ldap que hen creat abans. 
```bash
mkdir certs ; cd certs 

openssl req -new -newkey rsa:2048 -keyout martakey.pem -nodes -out martacsr.pem

Generating a 2048 bit RSA private key
.........................................................+++
......+++
writing new private key to 'martakey.pem'
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
Common Name (eg, your name or your server's hostname) []:marta
Email Address []:marta@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
 
```

Despres de crear el *request* el signen amb la CA que es troba en **/etc/openldap/certs** carpeta que el openldap guarda els seus certificats. 

Nota : tenin que recordar que per poder signar aquest certificat el usuari que signa amb CA ha de estar autorizat de poguer signar o sigui que tingui permisos .


```bash

openssl x509 -CA /etc/openldap/certs/cacrt.pem  -CAkey /etc/openldap/certs/cakey.pem  -req -in martacsr.pem  -CAcreateserial -out martacert.pem
Signature ok
subject=/C=ES/ST=Barcelona/L=Barcelona/O=Escola del treball /OU=Informatica/CN=marta/emailAddress=marta@edt.org
Getting CA Private Key
Enter pass phrase for /etc/openldap/certs/cakey.pem:


```

Ara tenin que donar permisos a tots els certificats i claus. En aquest cas el usuari i grup que estem utilitzant per fer exemple es nick. Per tant donaren permisos a tot el que esta dins d'aquesta carpeta certs

```bash

chown  user.user *

```

Ara al *home* del usuari hen de crear un fitxer ocul anomenat **.ldaprc** de configuracio molt similar aquest:
Nota : Aquest fitxer determina el client ldap pero te preferencia davant el fitxer **/etc/openldap/ldap.conf** fitxer de configuració client per defecte.



```bash

SASL_MECH EXTERNAL
TLS_CERT /path/certificate.pem
TLS_KEY /path/certificatekey.pem
TLS_CACERT /etc/openldap/certs/cacrt.pem

```



## Server

Aquesta configuració es la mateixa que abans per permetre el STARTTLS pero en aquest cas per permetre la authenticacio d'un usuari mitjançant certificats en de afegir la opcio **TLSVerifyClient** que el valor adequat es  **demand**


```bash

#SSL certificate file paths
TLSCACertificateFile /etc/openldap/certs/ca.cert
TLSCertificateFile /etc/openldap/certs/ldapserver.pem
TLSCertificateKeyFile /etc/openldap/certs/ldap.key
TLSCipherSuite HIGH:MEDIUM:+SSLv2
TLSVerifyClient demand

```

| TLSVerifyClient |                                                                    Opcions                                                  |
| --------------- |:---------------------------------------------------------------------------------------------------------------------------:|
| never           | Opcio per defecte (autenticació SIMPLE) . El server no fa "request certificate" al client                                   |
| allow           | "Request certificate". Si no es proporciona un certificat o si el certificat es incorrecte, la sessio continuara            |
| try             | "Request certificate". Si no es proporciona un certificat la sessio continuara pero si el certificat es incorrecte es tanca |
| demand          | "Request certificate". Si no es proporciona un certificat o si el certificat es incorrecte, la sessio tancara               |

Nomes usuaris que donin un certificats correctes seran capaços de establir un connexio.

Per poguer fer el mapping dels certificats cap als usuaris del ldap hen de afegir un linia mes al slapd.conf 
En la part de la configuració de la DB

```bash

authz-regexp "^email=([^,]+),cn=([^,]+).*,c=ES$" "uid=$2,ou=alumnes,dc=edt,dc=org"


```

Per poder comprovar si es correcte la configuració, crearen un certificat amb el usuari marta.
Crearen un request amb el common name marta 

```bash
openssl req -new -newkey rsa:2048 -keyout martakey.pem -nodes -out martacsr.pem
Generating a 2048 bit RSA private key
....+++
...............................+++
writing new private key to 'martakey.pem'
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
Organizational Unit Name (eg, section) []:becarios
Common Name (eg, your name or your server's hostname) []:marta
Email Address []:marta@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

Signen el request de marta amb el CA i avalen a marta. Amb aquest certificat podra fer una connexio sense proporcionar password al servidor ldap. 

```bash
 openssl x509 -CA /etc/openldap/certs/cacrt.pem -CAkey /etc/openldap/certs/cakey.pem -req -in martacsr.pem -CAcreateserial -out martacert.pem
Signature ok
subject=/C=ES/ST=Barcelona/L=Barcelona/O=Escola del treball/OU=becarios/CN=marta/emailAddress=marta@edt.org
Getting CA Private Key

```

Comproven que es correcte fem una connexio amb ldapwhoami. Poden veure que fa el mapping correctament 

```bash
ldapwhoami  -ZZ
SASL/EXTERNAL authentication started
SASL username: email=marta@edt.org,cn=marta,ou=becarios,o=Escola del treball,l=Barcelona,st=Barcelona,c=ES
SASL SSF: 0
dn:uid=marta,ou=alumnes,dc=edt,dc=org

```
