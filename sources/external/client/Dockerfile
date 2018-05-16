#Projecte Autenticació external
#LDAP SERVER EXTERNAL


FROM fedora:24
MAINTAINER nick@edt "LDAP CLIENT AUTHENTICATION "
RUN dnf -y install openldap-clients passwd
RUN useradd pere 
RUN  echo "pere" |  passwd pere --stdin
RUN useradd marta 
RUN echo "marta" |  passwd marta --stdin
RUN useradd anna 
RUN echo "anna"  |  passwd anna --stdin
RUN mkdir ~pere/certs
RUN mkdir ~marta/certs
RUN mkdir ~anna/certs
WORKDIR /opt/docker
COPY * /opt/docker/
RUN mv /opt/docker/ldap.conf /etc/openldap/ldap.conf
RUN mv /opt/docker/cacrt.pem /etc/openldap/certs
RUN mv /opt/docker/ldaprcmarta ~marta/.ldaprc
RUN mv /opt/docker/ldaprcpere ~pere/.ldaprc
RUN mv /opt/docker/ldaprcanna ~anna/.ldaprc
RUN cp /opt/docker/marta* ~marta/certs
RUN cp /opt/docker/pere* ~pere/certs
RUN cp /opt/docker/anna* ~pere/certs
CMD ["/bin/bash"]
EXPOSE 389 636
