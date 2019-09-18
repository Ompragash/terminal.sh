#!/bin/sh

ansible-tower-service stop

yum remove ansible-tower\* -y

yum remove ansible -y

#rpm -e --noscripts PACKAGE_NAME

yum -y remove rabbitmq-server erlang

yum remove postgresql\* -y

yum remove -y python-psycopg2 python-setuptools libselinux-python setools-libs yum-utils

rm -rf /etc/tower /var/lib/{pgsql,awx,rabbitmq,tower-bundle}

rpm -qa | grep ansible-tower\*
