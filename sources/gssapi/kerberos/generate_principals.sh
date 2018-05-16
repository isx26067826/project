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
