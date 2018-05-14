rm -rf /etc/openldap/slapd.d/* 
rm -rf /var/lib/ldap/*
cp DB_CONFIG /var/lib/ldap
slaptest -f slapd.conf -F /etc/openldap/slapd.d/ 
slaptest -f slapd.conf -F /etc/openldap/slapd.d/ -u
slapadd -F /etc/openldap/slapd.d/ -l dataDBuid.ldif
chown -R ldap.ldap /var/lib/ldap
chown -R ldap.ldap /etc/openldap/slapd.d/
