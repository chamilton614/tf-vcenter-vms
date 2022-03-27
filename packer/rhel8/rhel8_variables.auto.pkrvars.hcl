

vcenter_server   = "vcenter01.home"
vsphere_username = "administrator@vcenter01.home"
vsphere_password = "P@ssw0rd"
datastore        = "datastore2"
host             = "esxhost01.home"
datacenter       = "Datacenter"
folder           = "Templates"
cluster          = "Cluster"
network          = "Non-OCP"
boot_wait        = "5s"
#boot_iso="[datastore2] ISOs/rhel-8.4-x86_64-dvd.iso"
boot_iso         = "./package/iso/rhel-8.5-x86_64-dvd.iso"
#boot_iso_checksum = "~/development/git/chamilton614/tf-vcenter-vms/packer/rhel8/package/iso/rhel-8.4-sha256-checksum.txt"
boot_iso_checksum = "1f78e705cd1d8897a05afa060f77d81ed81ac141c2465d4763c0382aa96cadd0"
guest_os_type    = "rhel8_64Guest"
memsize          = "4096"
numvcpus         = "2"
disk_size        = "61440"
ssh_password     = "packer"
ssh_username     = "packer"
os_type          = "rhel"
os_version       = "8.5"
vm_name          = "tpl_st_"
kickstart_config = "ks-new.cfg"