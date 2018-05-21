# SSF

Hi ha algun parametre per determinar el grau de protecció que accepta una base de dades? La reposta es el SSF ( Security Strength Factors ), el servidor
ldap pot garantir la protecció i integritat de les dades tant propies com les que viatgen. Aquesta control també es pot aplicar tant al encriptació TLS com als
diferents metodes d'autenticació SASL, i per suposat el mode Simple. 

Per poguer comprovar aquest metode he comprovat aquesta configuració amb el exemple de GSSAPI. Per tant aquesta configuració sera molt semblant al model 
[GSSAPI](https://github.com/isx26067826/project/tree/master/sources/gssapi.md) ja instalat abans. Pero amb algunes petites modificacions com aquesta :

# Servidor Ldap


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


En aquest per comprovar hen escollit l'opció *update_ssf* i l'asignen un valor de 256 molt similar al ssf que obtenin amb gssapi. Encara que no hen especificat 
l'opció *ssf* per tant aquesta tindra el valor per defecte 0.

```bash

security update_ssf=256

```
Aquest parametre pot estar definit be en la configuració de una de les base de dades si hi ha mes d'una o poden definirla en les opcions global, això fara
que totes les base de dades tinguin les mateixer regles ssf.


# Client

En aquest cas el client podra comprovar que correctament pot fer consultes ja que el valor ssf es 0 pero quan qualsevol client desitgi modificar alguna dada
en el directori haura de utilitzar algun mecanisme d'autenticació amb un ssf superior o igual a 256.

Com ha client com autenticació simple no hi ha cap problema
                
```bash

ldapwhoami -x
anonymous

```

Pero si volen fer alguna modificació del directori la resposta no esta permes fer el update amb aquest metode d'autenticació.

```bash

ldapmodify -x -D "uid=pere,ou=alumnes,dc=edt,dc=org" -w pere -f modify.ldif 
modifying entry "uid=pere,ou=alumnes,dc=edt,dc=org"
ldap_modify: Confidentiality required (13)
	additional info: confidentiality required for update

```
Si volen modificar el directori hen de utilitzar algun mecanisme que sigüi igual o superi el 256 de la seguretat . Com per exemple GSSAPI es per aixà trien un
tiquet amb un principal *pere/alumnes*.

```bash

kinit pere/alumnes
Password for pere/alumnes@EDT.ORG: 

```

Comproven que correctament tenin el tiquet correcte.

```bash

klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: pere/alumnes@EDT.ORG

Valid starting     Expires            Service principal
05/21/18 22:18:04  05/22/18 22:18:04  krbtgt/EDT.ORG@EDT.ORG

```

I ara si, en aquest cas si que poden fer la modificació per que hen utilitzat un mecanisme que les ssf permeten fer la modificació.

```bash

ldapmodify -Y GSSAPI -f modify.ldif 
SASL/GSSAPI authentication started
SASL username: pere/alumnes@EDT.ORG
SASL SSF: 256
SASL data security layer installed.
modifying entry "uid=pere,ou=alumnes,dc=edt,dc=org"

```


Si vols practicar i experimentar amb aquesta configuració del model de protecció sssf et convido a poguer fer-lo
tu mateix, dona click [aquí](https://github.com/isx26067826/project/tree/master/sources/ssf-execute.md)

