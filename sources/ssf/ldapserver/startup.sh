#! /bin/bash
/usr/bin/echo "LDAP SERVER"
/usr/bin/kadmin -p admin/admin -w kadmin -q "ktadd -k /etc/krb5.keytab ldap/ldapserver.edt.org"
/usr/bin/chown ldap.ldap /etc/krb5.keytab
/usr/sbin/slapd -d0 -u ldap -h "ldap:/// ldaps:/// ldapi:///"
