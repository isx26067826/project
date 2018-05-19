#Projecte Autenticació external
#LDAP CLIENT EXTERNAL


FROM fedora:24
MAINTAINER nick@edt "LDAP CLIENT AUTHENTICATION "
RUN dnf -y install openldap-clients passwd
# Creació dels tres usuaris marta,pere i anna
RUN useradd pere 
RUN  echo "pere" |  passwd pere --stdin
RUN useradd marta 
RUN echo "marta" |  passwd marta --stdin
RUN useradd anna 
RUN echo "anna"  |  passwd anna --stdin
#Construcció dels directoris on guardarem els seus certificats
RUN mkdir ~pere/certs
RUN mkdir ~marta/certs
RUN mkdir ~anna/certs
WORKDIR /opt/docker
COPY * /opt/docker/
# Modificar i moure els fitxers de configuració que en exportat de les carpetas del sistema
RUN mv /opt/docker/ldap.conf /etc/openldap/ldap.conf
RUN mv /opt/docker/cacrt.pem /etc/openldap/certs
RUN mv /opt/docker/ldaprcmarta ~marta/.ldaprc
RUN mv /opt/docker/ldaprcpere ~pere/.ldaprc
RUN mv /opt/docker/ldaprcanna ~anna/.ldaprc
RUN cp /opt/docker/marta* ~marta/certs
RUN cp /opt/docker/pere* ~pere/certs
RUN cp /opt/docker/anna* ~anna/certs
# Donar permisos al usuaris als seus certificats
RUN /usr/bin/chown -R pere.pere ~pere/certs
RUN /usr/bin/chown -R marta.marta ~marta/certs
RUN /usr/bin/chown -R anna.anna ~anna/certs
CMD ["/bin/bash"]
EXPOSE 389 636
