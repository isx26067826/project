# Client Certificate

Per poguer fer aquest certficat necesitaren que alguna algun *Certificate Authority* que avali. Sera el mateix que avala el del servidor de ldap que hen creat abans. 
```bash
[nick@i16 ~]$ openssl req -new -newkey rsa:2048 -keyout martakey.pem -nodes -out martacsr.pem
Generating a 2048 bit RSA private key
.........................................................+++
......+++
writing new private key to 'martakey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ES
State or Province Name (full name) []:Barcelona
Locality Name (eg, city) [Default City]:Barcelona
Organization Name (eg, company) [Default Company Ltd]:Escola del treball 
Organizational Unit Name (eg, section) []:Informatica
Common Name (eg, your name or your server's hostname) []:marta
Email Address []:marta@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
 
```
