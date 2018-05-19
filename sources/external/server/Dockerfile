#Projecte Autenticació external
#LDAP SERVER EXTERNAL


FROM fedora
MAINTAINER nick@edt "LDAP AUTH CERTIFICATES "
RUN dnf -y install openldap  openldap-servers
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
# Modificar i moure els fitxers de configuració que en exportat de les carpetas del sistema
RUN cp /opt/docker/ca* /etc/openldap/certs/
RUN cp /opt/docker/ldapserver* /etc/openldap/certs/
# EN aquest script bash configuren el servidor slapd, generen la base de dades i donen permisos per que el usuari ldap per que el servei slapd es pugui encendre.
RUN /opt/docker/createDB.sh
CMD ["/opt/docker/startup.sh"]
#CMD ["/bin/bash"]
EXPOSE 389 636
