# Creació d'un certificat caducat



```bash
openssl ca -out perecert.pem -startdate 180215080000Z -enddate 180315080000Z -cert /home/users/inf/hisx2/isx26067826/project/sources/external/client/cacrt.pem  -keyfile /home/users/inf/hisx2/isx26067826/project/sources/external/client/cakey.pem -infiles perecsr.pem
Using configuration from /etc/pki/tls/openssl.cnf
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number:
            dc:3d:93:4a:e4:54:b3:7c
        Validity
            Not Before: Feb 15 08:00:00 2018 GMT
            Not After : Mar 15 08:00:00 2018 GMT
        Subject:
            countryName               = ES
            stateOrProvinceName       = Barcelona
            organizationName          = Barcelona
            organizationalUnitName    = Barcelona
            commonName                = pere
            emailAddress              = pere@edt.org
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            Netscape Comment:
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier:
                26:A5:81:31:29:E2:63:BE:7F:AB:DC:02:CE:F5:F8:FD:DA:32:7E:3B
            X509v3 Authority Key Identifier:
                keyid:EF:5B:CB:55:E0:2E:3F:20:69:7E:19:76:CF:BF:82:24:9C:E0:EC:E3

Certificate is to be certified until Mar 15 08:00:00 2018 GMT (-62 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated

```

