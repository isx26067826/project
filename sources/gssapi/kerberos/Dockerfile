#Projecte Servidor Kerberos Autenticació GSSAPI
#KERBEROS SERVER

FROM fedora
MAINTAINER nick@edt "Kerberos Server EDT.ORG  "
RUN dnf install -y krb5-server krb5-workstation krb5-libs
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
# Modificar i moure els fitxers de configuració que en exportat de les carpetas del sistema
RUN  mv /opt/docker/krb5.conf /etc/krb5.conf
RUN mv /opt/docker/kdc.conf /var/kerberos/krb5kdc/
RUN mv /opt/docker/kadm5.acl /var/kerberos/krb5kdc/
# Creació de la base de dades que emmagatzema el principals i les keys
RUN /usr/sbin/kdb5_util create -P masterkey -s
# Creació del principal pel servei ldap 
RUN /usr/sbin/kadmin.local -q "addprinc -pw randkey ldap/ldapserver.edt.org"
# Script que donat un fitxer creara els principals amb keys.
RUN /usr/bin/bash /opt/docker/generate_principals.sh
# El container encendra amb el servidor kerberos en back-ground amb l'execució del script startup.sh
CMD ["/opt/docker/startup.sh"]
# Exposar el ports per que es puguin fer la comunicació amb el servidor kerberos
EXPOSE 749 464 88
