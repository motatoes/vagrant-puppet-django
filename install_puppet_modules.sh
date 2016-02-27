#!/bin/bash
echo "i was here"
#This script installs puppet on the puppet environment before provisioning is performed

# first update the repo packages
sudo apt-get update

# install some packages that we need 
sudo apt-get -y install git

mkdir -p /etc/puppet/modules;
mkdir -p /usr/share/puppet/modules;

# install apache module if not already installed
if [ ! -d /etc/puppet/modules/apache ]; then
   puppet module install puppetlabs-apache
fi

# install nginx module if not already installed
if [ ! -d /etc/puppet/modules/nginx ]; then
    puppet module install puppetlabs-nginx
fi

# install the postrgesql module
if [ ! -d /etc/puppet/modules/postgresql ]; then
    puppet module install puppetlabs-postgresql
fi

# in order to add a user to the sudoers 
if [ ! -d /etc/puppet/modules/sudo ]; then
    puppet module install saz-sudo
fi

# to install python
if [ ! -d /etc/puppet/modules/python ]; then
    git clone https://github.com/stankevich/puppet-python /etc/puppet/modules/python
fi


