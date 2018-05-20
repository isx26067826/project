#Projecte Autenticació external
#LDAP CLIENT StartTLS


FROM fedora:24
MAINTAINER nick@edt "LDAP CLIENT AUTHENTICATION "
RUN dnf -y install openldap-clients 
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
# Modificar i moure els fitxers de configuració que en exportat de les carpetas del sistema
RUN mv /opt/docker/ldap.conf /etc/openldap/ldap.conf
RUN mv /opt/docker/cacrt.pem /etc/openldap/certs
CMD ["/bin/bash"]
EXPOSE 389 636
