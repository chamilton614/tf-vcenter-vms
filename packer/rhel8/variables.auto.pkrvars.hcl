

vcenter_server="vcenter01.home"
vsphere_username="administrator@vcenter01.home"
vsphere_password="P@ssw0rd"

#vcenter_server="esxhost01.home"
#vsphere_username="root"
#vsphere_password="r3dh4t1!"
# Use vcenter_host if a network variable below is not going to be specified
#vsphere_host="sdcpiesx714.white.aim.local"

cluster="Cluster"
datacenter="Datacenter"
# Use network if a vcenter_host variable above is not going to be specified
network="Non-OCP"
datastore="datastore2"
folder="Templates"

boot_wait="30s"

# Boot ISO to use
# Boot ISO RHEL 8.4 from Datastore
#boot_iso="[SDC-NPD-vsan] ISOs/rhel-8.4-x86_64-dvd.iso"
# Boot ISO RHEL 8.4 from Local Directory
boot_iso         = "./package/iso/rhel-8.4-x86_64-dvd.iso"
# Boot ISO RHEL 8.5 from Local Directory
#boot_iso         = "./package/iso/rhel-8.4-x86_64-dvd.iso"

# Boot ISO Checksum for RHEL 8.4
#boot_iso_checksum = "48f955712454c32718dcde858dea5aca574376a1d7a4b0ed6908ac0b85597811"
boot_iso_checksum = "package/iso/rhel-8.4-checksum.txt"
# Boot ISO Checksum for RHEL 8.5
#boot_iso_checksum = "48f955712454c32718dcde858dea5aca574376a1d7a4b0ed6908ac0b85597811"

# List of VMware Guest OS Types - https://developer.vmware.com/apis/358/vsphere/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html
guest_os_type="rhel8_64Guest"

# CPUs
numvcpus="2"

# RAM 4GB = 4096
memsize="4096"

# Storage - primary and secondary.  Must have at least a value for primary.  Secondary can be ignored with or without a value if only using 1 drive just update build file.
# 40GB = 40960 60GB = 61440
disk_size_primary="40960"
disk_size_secondary="61440"

# SSH Connection information to VM to perform Post-Install tasks
ssh_username="packer"
ssh_password="packer"

# VM Name for the Template
vm_name="tpl_rhel8"

# Name of Kickstart File to use for auto installation
kickstart_config="ks.cfg"