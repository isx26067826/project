# LDAP GSSAPI

## GENERIC SECURITY SERVICE APPLICATION PROGRAM INTERFACE

OPENLDAP es una bona implementacio del protocol LDAP. Podrien parla de totes les utilitats i beneficis que te, pero no poden oblidar un mancança.
La autenticació o sigui el enviament de totes les dades necesaries per demostrat al servidor qui som ser, viatgen per la xarxa en text pla. Com poden veure en la seguent imatge:

![Alt text](https://github.com/isx26067826/project/blob/master/sources/wireshark-simple.jpg "Simple Authentication")

- [Simple](https://github.com/isx26067826/project/tree/master/sources/simple.md)

- [Digest/MD5](https://github.com/isx26067826/project/tree/master/sources/digest-md5.md)

- [External](https://github.com/isx26067826/project/tree/master/sources/external.md)

- [GSSAPI](https://github.com/isx26067826/project/tree/master/sources/external.md)


OPENLDAP per defecte no te la seva comunicació encriptada es per aixo que permet un metode de encriptació per fer-lo mes segur, aquest metode de seguretat es diu [StartTLS](https://github.com/isx26067826/project/tree/master/sources/starttls.md). Aquest metode ens dona encriptació mitjançant certificats. Abans OPENLDAP separa els ports amb la finalitat que un fos comunicació sense encriptar (port 389) i l'altre encriptar (port 636) tot aixo ja esta **deprecated** i STARTTLS permet fer tant conexions xifradas pel mateix port. 
