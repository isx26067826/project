#Projecte Autenticació external
#LDAP SERVER EXTERNAL


FROM fedora:24
MAINTAINER nick@edt "LDAP CLIENT AUTHENTICATION "
RUN dnf -y install openldap-clients 
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN mv /opt/docker/ldap.conf /etc/openldap/ldap.conf
RUN mv /opt/docker/cacrt.pem /etc/openldap/certs


CMD ["/bin/bash"]
EXPOSE 389 636
