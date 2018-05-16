#Projecte Autenticació GSSAPI
#LDAP SERVER GSSAPI


FROM fedora
MAINTAINER nick@edt "LDAP AUTH CERTIFICATES "
RUN dnf -y install krb5-workstation krb5-libs openldap-clients cyrus-sasl-gssapi cyrus-sasl-ldap
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN  mv /opt/docker/krb5.conf /etc/krb5.conf
RUN cp /opt/docker/ca* /etc/openldap/certs/
RUN cp /opt/docker/ldap.conf /etc/openldap/
CMD ["/bin/bash"]
EXPOSE 389 636
                                     

