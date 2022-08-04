#!/bin/bash -eux

echo "cleanup.sh"

#Remove Ansible
#pip3 uninstall -y ansible

#Clean up Yum
#yum clean all

#Clear out machine id"
rm -f /etc/machine-id
touch /etc/machine-id

#Clean up /tmp
rm -rf /tmp/*

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync