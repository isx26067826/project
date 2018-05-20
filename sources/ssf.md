# SSF

Hi ha algun parametre per determinar el grau de protecció que accepta una base de dades? La reposta es el SSF ( Security Strength Factors ), el servidor
ldap pot garantir la protecció i integritat de les dades tant propies com les que viatgen. Aquesta control també es pot aplicar tant al encriptació TLS com als
diferents metodes d'autenticació SASL, i per suposat el mode Simple. 

L'opció que utilitza el fitxer de configuració es *security* que determina les diferents regles que ha complir, algunes son aquestes:




security ssf=256 

[root@client docker]# ldapwhoami -x 
ldap_parse_result: Confidentiality required (13)
	additional info: confidentiality required
Result: Confidentiality required (13)
Additional info: confidentiality required
[root@client docker]# kinit pere/alumnes
Password for pere/alumnes@EDT.ORG: 
[root@client docker]# ldapwhoami -Y GSSAPI -ZZ
SASL/GSSAPI authentication started
SASL username: pere/alumnes@EDT.ORG
SASL SSF: 256
SASL data security layer installed.
dn:uid=pere,ou=alumnes,dc=edt,dc=org

