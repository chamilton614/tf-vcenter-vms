#!/bin/bash -eux

echo 'cleanup.sh'

#Check if Pip3 is installed
if [ command -v pip3 >/dev/null 2>&1 ]
then
    echo 'pip3 is installed.  Removing ansible.'
    #Remove Ansible
    pip3 uninstall -y ansible
fi

#Clean up Yum
yum clean all

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