#!/usr/bin/env bash

# Create ubuntu 13.10 server
apt-get update
apt-get -y upgrade
apt-get install -y gnuplot-nox libtemplate-perl libhtml-template-perl libhtml-template-expr-perl
apt-get install -y gnuplot  make gcc git automake autoconf libtool build-essential python-pip
apt-get install -y m4 libncurses5-dev libssh-dev libssl-dev unixodbc-dev libgmp3-dev libwxgtk2.8-dev libglu1-mesa-dev fop xsltproc default-jdk
pip install pyrax

# install erlang
cd ~
wget http://www.erlang.org/download/otp_src_R15B01.tar.gz
tar xvf otp_src_R15B01.tar.gz
cd otp_src_R15B01
./configure
make
make install

# install tsung
cd ~
wget http://tsung.erlang-projects.org/dist/tsung-1.5.1.tar.gz
tar xvf tsung-1.5.1.tar.gz
cd tsung-1.5.1
chmod 755 configure
./configure
make
make install

# source required shell variables
cd ~
cp -r csi-marconi/load ~/.tsung

# check if the variables have been set properly
if [[ -z "$REGION" ]] || [[ -z "$TENANT_ID" ]] || [ "$REGION" = "reg" ] || [ "$TENANT_ID" = "tenant_id" ]
then
    echo "Please use valid TENANT_ID and REGION or update them in tsungrc"
fi

# Update the tsung.xml
# for a single node setup, skip the two commented steps below
# Update the <clients> section of ~/.tsung/tsung.xml, to point to your tsung machines. (Do not use IP addresses here.)
# Update the <servers> section, to point to your marconi server.
sed -i "s/REGION/${REGION}/g" ~/.tsung/tsung.xml
sed -i "s/TENANT_ID/${TENANT_ID}/" ~/.tsung/auth.csv
# Update ~/.tsung/projectid.csv, to include the tenant ID of your account.
sed -i "s/PROJECT_ID/${TENANT_ID}/g" ~/.tsung/projectid.csv

# Increase file descriptors available.
echo root soft  nofile 9000  >> /etc/security/limits.conf
echo root hard  nofile 65000 >> /etc/security/limits.conf
