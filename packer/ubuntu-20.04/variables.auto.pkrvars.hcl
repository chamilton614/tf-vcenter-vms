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
template_vm_name               = "pkr_tmpl_ubuntu2004_100GB"
guest_os_type                  = "ubuntu64Guest"
hardware_version               = 19
firmware                       = "bios"
convert_to_template            = false
create_snapshot                = false
cdrom_type                     = "sata"
num_cpu_sockets                = 1
num_cpu_cores                  = 2
memsize                        = 4096
disk_size                      = 102400
thin_provisioned               = true
disk_eagerly_scrub             = false
disk_controller_type           = ["pvscsi"]
network_card                   = "vmxnet3"
network                        = "Non-OCP"
boot_wait                      = "5s"
iso_paths                      = ["[datastore2] ISOs/Ubuntu/ubuntu-20.04.4-live-server-amd64.iso"]
ssh_username                   = "ubuntu"
ssh_password                   = "P@ssw0rd"

# Script Configurations
scripts_directory              = "package/scripts"
install_scripts                = ["package/scripts/cleanup.sh"]