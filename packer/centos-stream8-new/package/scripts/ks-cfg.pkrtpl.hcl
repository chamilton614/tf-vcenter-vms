# Kickstart file for RHEL 8 / CentOS 8 / CentOS Stream 8

#Language for the installation
lang en_US

# Configure network information for target system and activate network devices in the installer environment (optional)
# --onboot	enable device at a boot time
# --device	device to be activated and / or configured with the network command
# --bootproto	method to obtain networking configuration for device (default dhcp)
# --noipv6	disable IPv6 on this device
#
# NOTE: Usage of DHCP will fail CCE-27021-5 (DISA FSO RHEL-06-000292). To use static IP configuration,
#       "--bootproto=static" must be used. For example:
# network --bootproto=static --ip=10.0.2.15 --netmask=255.255.255.0 --gateway=10.0.2.254 --nameserver 192.168.2.1,192.168.3.1
#
# Static IP: network --onboot=yes --device=ens192 --bootproto=static --ip=10.0.2.15 --netmask=255.255.255.0 --gateway=10.0.2.254 --nameserver=192.168.2.1,192.168.3.1 --noipv6 --hostname=<hostname>
# DHCP IP:   network --onboot=yes --device=ens192 --bootproto=dhcp --noipv6 --hostname=<hostname>
network --onboot=yes --device=ens192 --bootproto=dhcp --noipv6 --hostname=server-${serverbuildtime}
#network --bootproto=dhcp --device=ens192 --noipv6 --no-activate

keyboard us
timezone America/New_York --isUtc
#Root password is server
rootpw $2b$10$EUFzVq9Vy5TXC6PzdSLddurXITR80GBqc53GWqSKZNpgcaeT0EvCy --iscrypted
# The selected profile will restrict root login
# Add a user that can login and escalate privileges
# Plaintext password is: admin123
# Username:Password - admin:admin123
# user --name=admin --groups=wheel --password=$6$Ga6ZnIlytrWpuCzO$q0LqT1USHpahzUafQM9jyHCY9BiE5/ahXLNWUMiVQnFGblu0WWGZ1e6icTaCGO4GNgZNtspp1Let/qpM7FMVB0 --iscrypted
# Add a user named packer
user --groups=wheel --name=packer --password=$6$Jaa5U0EwAPMMp3.5$m29yTwr0q9ZJVJGMXvOnm9q2z13ldUFTjB1sxPHvaiW4upMSwQ50181wl7SjHjh.BTH7FGHx37wrX..SM0Bqq. --iscrypted --gecos="packer"
#platform x86_64
reboot
text
cdrom
bootloader --append="rhgb quiet crashkernel=auto"
zerombr

# Remove partitions
clearpart --all --initlabel

# Automatically create partitions using LVM
autopart

#auth --passalgo=sha512 --useshadow
selinux --enforcing
firewall --enabled --ssh
skipx
firstboot --disable

# Local Repo to get packages installed
repo --name="AppStream" --baseurl=file:////run/install/sources/mount-0000-cdrom/AppStream

%pre --interpreter=/usr/bin/bash
echo "%pre script section - runs after system is partitioned, file systems created and mounted and network has been configured according to any boot options"
%end

%packages --ignoremissing
#@^minimal-environment
@^server-product-environment
@development
kexec-tools
open-vm-tools
# Exclude unnecessary firmwares
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl*-firmware
-libertas-usb8388-firmware
-ql*-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware
-cockpit
-quota
-alsa-*
-fprintd-pam
-intltool
-microcode_ctl

%end

%post --logfile=/root/ks-post.log --interpreter=/usr/bin/bash
echo "post script section - runs after install but before reboot - can be used for system subscription"
# Disable quiet boot and splash screen
sed --follow-symlinks -i "s/ rhgb quiet//" /mnt/sysimage/etc/default/grub
sed --follow-symlinks -i "s/ rhgb quiet//" /mnt/sysimage/boot/grub2/grubenv

# Passwordless sudo for the user 'packer'
echo "packer ALL=(ALL) NOPASSWD: ALL" >> /mnt/sysimage/etc/sudoers.d/packer
%end
