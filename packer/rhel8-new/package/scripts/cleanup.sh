#!/bin/bash -eux

echo "cleanup.sh"

#Remove Ansible
echo "Removing Ansible"
#pip3 uninstall -y ansible
python -m pip uninstall -y ansible

#Clean up Yum
echo "Clean up Yum"
yum clean all

#Clear out machine id"
echo "Clear out machine id"
rm -f /etc/machine-id
touch /etc/machine-id

#Clean up /tmp
echo "Clean up /tmp"
rm -rf /tmp/*

# Zero out the rest of the free space using dd, then delete the written file.
echo "Clear out free space"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
echo "Sync to keep Packer from exiting too soon"
sync