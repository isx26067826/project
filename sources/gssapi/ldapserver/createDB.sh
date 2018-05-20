#! /bin/bash
#Esborrar la carpeta de configuració i el directori d'emmagatzem de la BD
rm -rf /etc/openldap/slapd.d/* 
rm -rf /var/lib/ldap/*
# Establir la configuració del slapd
cp DB_CONFIG /var/lib/ldap
slaptest -f slapd.conf -F /etc/openldap/slapd.d/ 
slaptest -f slapd.conf -F /etc/openldap/slapd.d/ -u
# Injectar la base de dades
slapadd -F /etc/openldap/slapd.d/ -l dataDBuid.ldif
chown -R ldap.ldap /var/lib/ldap
chown -R ldap.ldap /etc/openldap/slapd.d/
