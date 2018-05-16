#! /bin/bash

#cut -f1 -d '/' usuaris

while read -r line 
do 

	user=$(echo $line)
	password=$(echo $line | cut -f1 -d '/')
	/usr/sbin/kadmin.local -q "addprinc -pw k$password $user"

done < usuaris 
