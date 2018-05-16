#Projecte Autenticació GSSAPI
#LDAP SERVER GSSAPI


FROM fedora
MAINTAINER nick@edt "LDAP AUTH CERTIFICATES "
RUN dnf -y install openldap  openldap-servers krb5­-workstation krb5­-libs
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN  mv /opt/docker/krb5.conf /etc/krb5.conf
RUN cp /opt/docker/ca* /etc/openldap/certs/
RUN cp /opt/docker/ldapserver* /etc/openldap/certs/
RUN /opt/docker/createDB.sh
RUN /usr/bin/kadmin -p admin/admin -w kadmin -q "ktadd -k /etc/krb5.keytab ldap/ldapserver.edt.org"
#CMD ["/opt/docker/startup.sh"]
CMD ["/bin/bash"]
EXPOSE 389 636
~                                     
