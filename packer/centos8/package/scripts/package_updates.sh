#!/bin/bash -eux

echo "package_updates.sh"

#Download Stream Repo Files
yum -y install centos-release-stream --disablerepo=* --enablerepo='extras'

#Enabling Stream-* allows the download of the latest GPG
yum swap centos-{linux,stream}-repos -y --disablerepo=* --enablerepo=extras,Stream-*

#Necessary to use the epel repos
yum config-manager --set-enabled powertools

#Sync the distro
yum distro-sync -y

#Update packages
yum -y update

#Install Python3
# yum -y install python3
yum -y install python3-pip

#Install pip 
pip3 install --upgrade pip

#Switch to use Python3 as Default
alternatives --set python /usr/bin/python3

#Install epel repo
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

#Install Ansible
#dnf -y install --enablerepo epel-playground ansible
#pip3 install ansible
yum -y install epel-release
yum -y install ansible