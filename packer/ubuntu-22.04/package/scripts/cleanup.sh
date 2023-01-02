#!/bin/bash -eux

echo "Package cleanup.sh"

# Output Date and Time
date

# Cleans all audit logs.
#echo '> Cleaning all audit logs ...'
#if [ -f /var/log/audit/audit.log ]; then
#    cat /dev/null > /var/log/audit/audit.log
#fi
#
#if [ -f /var/log/wtmp ]; then
#    cat /dev/null > /var/log/wtmp
#fi
#
#if [ -f /var/log/lastlog ]; then
#    cat /dev/null > /var/log/lastlog
#fi

# Cleans persistent udev rules.
#echo '> Cleaning persistent udev rules ...'
#if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
#    rm /etc/udev/rules.d/70-persistent-net.rules
#fi

# Cleans /tmp directories.
#echo '> Cleaning /tmp directories ...'
#rm -rf /tmp/*
#rm -rf /var/tmp/*

# Cleans SSH keys.
#echo '> Cleaning SSH keys ...'
#rm -f /etc/ssh/ssh_host_*

# Sets hostname to localhost.
#echo '> Setting hostname to localhost ...'
#cat /dev/null > /etc/hostname
#hostnamectl set-hostname localhost

# Cleans apt-get.
echo '> Cleaning apt-get ...'
apt-get clean
apt-get autoremove

# Cleans the machine-id.
#echo '> Cleaning the machine-id ...'
#truncate -s 0 /etc/machine-id
#rm /var/lib/dbus/machine-id
#ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleans shell history.
#echo '> Cleaning shell history ...'
#unset HISTFILE
#history -cw
#echo > ~/.bash_history
#rm -fr /root/.bash_history

# Cloud Init Nuclear Option
#echo '> Cloud Init Nuclear Option ...'
#rm -rf /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
#rm -rf /etc/cloud/cloud.cfg.d/99-installer.cfg
#echo "disable_vmware_customization: false" >> /etc/cloud/cloud.cfg
#echo "# to update this file, run dpkg-reconfigure cloud-init datasource_list: [ VMware, OVF, None ]" > /etc/cloud/cloud.cfg.d/90_dpkg.cfg
#touch /etc/cloud/cloud-init.disabled

# Set boot options to not override what we are sending in cloud-init
echo '> Modifying grub ...'
sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/" /etc/default/grub
update-grub

# Zero out the rest of the free space using dd, then delete the written file.
echo '> Zero out the free space ...'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
echo '> Sync to keep Packer from quitting early ...'
sync

# Output Date and Time
date

