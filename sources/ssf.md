



security ssf=256 

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

