#!/bin/bash
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid $KRB5KDC_ARGS
/usr/sbin/kadmind -nofork -P /var/run/kadmind.pid $KADMIND_ARGS
