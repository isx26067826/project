#Projecte Servidor Kerberos Autenticació GSSAPI
#KERBEROS SERVER

FROM fedora
MAINTAINER nick@edt "Kerberos Server EDT.ORG  "
RUN dnf install -y krb5-server krb5-workstation krb5-libs
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN  mv /opt/docker/krb5.conf /etc/krb5.conf
RUN mv /opt/docker/kdc.conf /var/kerberos/krb5kdc/
RUN mv /opt/docker/kadm5.acl /var/kerberos/krb5kdc/
RUN /usr/sbin/kdb5_util create -P masterkey -s
RUN /usr/bin/bash /opt/docker/generate_principals.sh
CMD ["/opt/docker/startup.sh"]
EXPOSE 749 464 88
