#!/bin/bash -eux

echo "cockpit.sh"

#Install Cockpit
yum install cockpit -y

#Enable the Cockpit Service
systemctl enable --now cockpit.socket

#Start the Cockpit Service
systemctl start cockpit