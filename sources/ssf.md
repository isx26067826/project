# SSF

Hi ha algun parametre per determinar el grau de protecció que accepta una base de dades? La reposta es el SSF ( Security Strength Factors ), el servidor
ldap pot garantir la protecció i integritat de les dades tant propies com les que viatgen. Aquesta control també es pot aplicar tant al encriptació TLS com als
diferents metodes d'autenticació SASL, i per suposat el mode Simple. 

L'opció que utilitza el fitxer de configuració es *security* que determina les diferents regles que ha complir, algunes son aquestes:


|  LDAP SERVER SSF     |                                              Opcions                                                   |
| -------------------- |:-------------------------------------------------------------------------------------------------------:|
| ssf		 	  	   | Defineix les ssf en general 																			 |
| transport     	   | Defineix les ssf en el transport                                      									 |
| tls		      	   | Defineix les ssf en el TLS									  											 |
| sasl		    	   | Defineix les ssf en el SASL																			 |
| update_ssf	 	   | Defineix les ssf en general per permetre la modificació del directori									 |
| update_transport 	   | Defineix les ssf en el transport per permetre la modificació del directori								 |
| update_tls    	   | Defineix les ssf en el TLS per permetre la modificació del directori									 |
| update_sasl    	   | Defineix les ssf en el SASL per permetre la modificació del directori									 |
| simple_bind    	   | Directiva encarregada de fer un traduccion entre els usuaris sasl a usuaris simples de la base de dades |


# Servidor 





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



     access to *
                by ssf=128 self write
                by ssf=64 anonymous auth
                by ssf=64 users read
                
En este caso validamos el para que los usuarios puedan hacer todo tipo de consultas pero cuando desean hacer alguna modificació ha de ser un ssf de 256

```bash

security update_ssf=256

```




docker network create --subnet 172.70.0.0/24 --gateway 172.70.0.1 ssf


docker run --name skerberos -h skerberos.edt.org --net=ssf --add-host=ldapserver.edt.org:172.70.0.3 --ip 172.70.0.2 -d kerberos 


docker run --name ldapserver -h ldapserver.edt.org --net ssf --add-host=skerberos.edt.org:172.70.0.2 --ip 172.70.0.3 -it ldapserver 


docker run --name client -h client.edt.org --net=ssf  --add-host=skerberos.edt.org:172.70.0.2 --add-host=ldapserver.edt.org:172.70.0.3 --ip 172.70.0.4 -it client
