#Projecte Autenticació external
#LDAP SERVER EXTERNAL


FROM fedora:24
MAINTAINER nick@edt "LDAP AUTH CERTIFICATES "
RUN dnf -y install nmap procps iputils iproute openldap openldap-clients openldap-servers
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN cp /opt/docker/ca* /etc/openldap/certs/
RUN cp /opt/docker/server* /etc/openldap/certs/
RUN /op/docker/createDB.sh
CMD ["/opt/docker/startup.sh"]
EXPOSE 389 636
