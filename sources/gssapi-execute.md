docker network create --subnet 172.50.0.0/24 --gateway 172.50.0.1 gssapi


KERBEROS

docker run --name skerberos -h skerberos.edt.org --net=gssapi --add-host=ldapserver.edt.org:172.50.0.3 --ip 172.50.0.2 -d kerberos


LDAP SERVER

docker run --name ldapserver -h ldapserver.edt.org --net gssapi --add-host=skerberos.edt.org:172.50.0.2 --ip 172.50.0.3 -d ldap


CLIENT

docker run --name client -h client.edt.org --net=gssapi  --add-host=skerberos.edt.org:172.50.0.2 --add-host=ldapserver.edt.org:172.50.0.3 --ip 172.50.0.4 -it client






