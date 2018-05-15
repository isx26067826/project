#Projecte Autenticació external
#LDAP SERVER EXTERNAL


FROM fedora:24
MAINTAINER nick@edt "LDAP AUTH CERTIFICATES "
RUN dnf -y install openldap  openldap-servers
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN cp /opt/docker/ca* /etc/openldap/certs/
RUN cp /opt/docker/ldapserver* /etc/openldap/certs/
RUN /opt/docker/createDB.sh
CMD ["/opt/docker/startup.sh"]
#CMD ["/bin/bash"]
EXPOSE 389 636
