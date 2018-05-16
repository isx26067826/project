#Projecte Servidor Kerberos
#KERBEROS SERVER

FROM fedora
MAINTAINER nick@edt "LDAP AUTH CERTIFICATES "
RUN dnf install -y krb5-server krb5-workstation krb5-libs
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN  mv /opt/docker/krb5.conf /etc/krb5.conf
RUN mv /opt/docker/kdc.conf /var/kerberos/krb5kdc/
RUN mv /opt/docker/kadm5.acl /var/kerberos/krb5kdc/
RUN /usr/sbin/kdb5_util create -P masterkey -s
RUN /usr/sbin/kadmin.local -q "addprinc -pw kpere pere"
RUN /usr/sbin/kadmin.local -q "addprinc -pw kmarta marta"
RUN /usr/sbin/kadmin.local -q "addprinc -pw kanna anna"
RUN /usr/sbin/kadmin.local -q "addprinc -pw kadmin admin/admin"
RUN /usr/sbin/kadmin.local -q "addprinc -pw randkey ldap/ldapserver"
#CMD ["/opt/docker/startup.sh"]
CMD ["/bin/bash"]
EXPOSE 749 464 88