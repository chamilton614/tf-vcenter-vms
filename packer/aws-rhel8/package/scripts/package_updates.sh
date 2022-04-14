#!/bin/bash -eux

echo "package_updates.sh"

#Update packages
#yum -y update
dnf -y update

#Install Python3
# yum -y install python3
dnf -y install python3-pip

#Install pip 
pip3 install --upgrade pip

#Switch to use Python3 as Default
alternatives --set python /usr/bin/python3

#Install Ansible
pip3 install ansible

#Install epel repo
# dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

#Install Ansible
# dnf -y install --enablerepo epel-playground ansible