#! /bin/bash
/usr/bin/echo "LDAP SERVER"
/usr/sbin/slapd -d0 -u ldap -h "ldap:/// ldaps:/// ldapi:///"
