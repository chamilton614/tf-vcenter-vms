#Auto variables for Packer

# vCenter Variables
vcenter_server                 = "vcenter01.home"
#vsphere_username              = ""
#vsphere_password              = ""
insecure_connection            = true
datastore                      = "datastore2"
host                           = "esxhost01.home"
datacenter                     = "Datacenter"
folder                         = "Templates"
cluster                        = "Cluster"

# Virtual Machine Variables
template_vm_name               = "pkr_tmpl_centos_stream8"
guest_os_type                  = "centos8_64Guest"
hardware_version               = 19
firmware                       = "bios"
convert_to_template            = true
create_snapshot                = false
cdrom_type                     = "sata"
num_cpu_sockets                = 1
num_cpu_cores                  = 2
memsize                        = 4096
disk_size                      = 61440
thin_provisioned               = true
disk_eagerly_scrub             = false
disk_controller_type           = ["pvscsi"]
network_card                   = "vmxnet3"
network                        = "Non-OCP"
boot_wait                      = "5s"
iso_paths                      = ["[datastore2] ISOs/CentOS/CentOS-Stream-8-x86_64-20230209-dvd1.iso"]
ssh_username                   = "root"
ssh_password                   = "server"

# Script Configurations
scripts_directory              = "package/scripts"
install_scripts                = ["package/scripts/cleanup.sh"]