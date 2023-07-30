#!/bin/bash -eux

echo "Package cleanup.sh"

# Output Date and Time
date

# Cleans all audit logs.
echo '> Cleaning all audit logs ...'

#if [ -f /var/log/audit/audit.log ]; then
#    cat /dev/null > /var/log/audit/audit.log
#fi

if [ -f /var/log/wtmp ]; then
    cat /dev/null > /var/log/wtmp
fi

if [ -f /var/log/lastlog ]; then
    cat /dev/null > /var/log/lastlog
fi

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
#echo '> Cleaning apt-get ...'
#apt-get clean
#apt-get autoremove

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

#Start From Bento - cleanup_ubuntu.sh
echo "remove linux-headers"
dpkg --list \
  | awk '{ print $2 }' \
  | grep 'linux-headers' \
  | xargs apt-get -y purge;

echo "remove specific Linux kernels, such as linux-image-3.11.0-15-generic but keeps the current kernel and does not touch the virtual packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep 'linux-image-.*-generic' \
    | grep -v "$(uname -r)" \
    | xargs apt-get -y purge;

echo "remove old kernel modules packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep 'linux-modules-.*-generic' \
    | grep -v "$(uname -r)" \
    | xargs apt-get -y purge;

echo "remove linux-source package"
dpkg --list \
    | awk '{ print $2 }' \
    | grep linux-source \
    | xargs apt-get -y purge;

echo "remove all development packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-dev\(:[a-z0-9]\+\)\?$' \
    | xargs apt-get -y purge;

echo "remove docs packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-doc$' \
    | xargs apt-get -y purge;

echo "remove X11 libraries"
apt-get -y purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6;

echo "remove obsolete networking packages"
apt-get -y purge ppp pppconfig pppoeconf;

echo "remove packages we don't need"
apt-get -y purge popularity-contest command-not-found friendly-recovery bash-completion laptop-detect motd-news-config usbutils grub-legacy-ec2

# 22.04+ don't have this
echo "remove the fonts-ubuntu-font-family-console"
apt-get -y purge fonts-ubuntu-font-family-console || true;

# 21.04+ don't have this
echo "remove the installation-report"
apt-get -y purge popularity-contest installation-report || true;

echo "remove the console font"
apt-get -y purge fonts-ubuntu-console || true;

echo "removing command-not-found-data"
# 19.10+ don't have this package so fail gracefully
apt-get -y purge command-not-found-data || true;

# Exclude the files we don't need w/o uninstalling linux-firmware
echo "Setup dpkg excludes for linux-firmware"
cat <<_EOF_ | cat >> /etc/dpkg/dpkg.cfg.d/excludes
#BENTO-BEGIN
path-exclude=/lib/firmware/*
path-exclude=/usr/share/doc/linux-firmware/*
#BENTO-END
_EOF_

echo "delete the massive firmware files"
rm -rf /lib/firmware/*
rm -rf /usr/share/doc/linux-firmware/*

echo "autoremoving packages and cleaning apt data"
apt-get -y autoremove;
apt-get -y clean;

echo "remove /usr/share/doc/"
rm -rf /usr/share/doc/*

echo "remove /var/cache"
find /var/cache -type f -exec rm -rf {} \;

echo "truncate any logs that have built up during the install"
find /var/log -type f -exec truncate --size=0 {} \;

echo "blank netplan machine-id (DUID) so machines get unique ID generated on boot"
truncate -s 0 /etc/machine-id

echo "remove the contents of /tmp and /var/tmp"
rm -rf /tmp/* /var/tmp/*

echo "force a new random seed to be generated"
rm -f /var/lib/systemd/random-seed

echo "clear the history so our install isn't there"
rm -f /root/.wget-hsts
export HISTSIZE=0
#End From Bento - cleanup_ubuntu.sh

# Set boot options to not override what we are sending in cloud-init
echo '> Modifying grub ...'
sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/" /etc/default/grub
update-grub

#Start From github.com/mcandre/packer-templates
# Shrink rootfs
count="$(df --sync -kP / | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count - 1))" &&
    dd if=/dev/zero of=/tmp/whitespace bs=1024 count="$count" ||
    echo 'Zeroed rootfs' &&
    rm /tmp/whitespace

# Shrink boot partition
count="$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count - 1))" &&
    dd if=/dev/zero of=/boot/whitespace bs=1024 count="$count" ||
    echo 'Zeroed boot partition' &&
    rm /boot/whitespace

# Shrink swap space
swapuuid="$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)" &&
    swappart="$(readlink -f "/dev/disk/by-uuid/${swapuuid}")" &&
    /sbin/swapoff "$swappart" &&
    dd if=/dev/zero of="$swappart" bs=1M ||
    echo 'Zeroed swap space' &&
    /sbin/mkswap -U "$swapuuid" "$swappart"
#End From github.com/mcandre/packer-templates

# Zero out the rest of the free space using dd, then delete the written file.
echo '> Zero out the free space ...'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
echo '> Sync to keep Packer from quitting early ...'
sync

# Output Date and Time
date

