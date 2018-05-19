# SIMPLE

L'autenticació simple del servei LDAP inclou tant 


- Anonymous ( usuari anonim)

- Usari no autenticat ( usuari que té DN pero no te password )

- Usuari amb nom (DN) i password valids


Tant el usuaris anonims com els usuaris que proporcionan password i noms valids estan dins de la autenticació simple per defecte . Si volen que el nostre 
servidor reconogui a usuaris no autenticats tant sols hen de establir el següent opcion en *slapd.conf* del servidor :

```bash

allow bind_anon_cred

```

## Exemples de simple autenticació

En l'autenticació anonymous unicament hen de realitzar una consulta sense identificar-nos amb un nom ni amb una password.

```bash

ldapwhoami -x 
anonymous

```

En l'autenticació simple hen de proporcinar al servidor tant un nom (DN) com una password valida i correcta.


```bash

ldapwhoami -x -D "uid=marta,o=tarda,ou=professors,dc=edt,dc=org" -w marta
dn:uid=marta,o=tarda,ou=professors,dc=edt,dc=org


```

Aquest metode no he creat cap estructura docker per comprovar per que es el metode per defecte conegut per tothom.
