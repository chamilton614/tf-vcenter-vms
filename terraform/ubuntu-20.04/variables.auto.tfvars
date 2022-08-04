#https://www.virtjunkie.com/vmware-provisioning-using-hashicorp-terraform/
#https://github.com/jonhowe/Virtjunkie.com/tree/master/Terraform

vsphere_server = "vcenter01.home"
#vsphere_user = ""
#vsphere_password = ""

adminpassword = "packer" 
datacenter = "Datacenter"
datastore = "datastore2" 
cluster = "Cluster"
network = "Management VMs" 

template_name = "tmpl_ubuntu_20_04"
vm_name = "ubuntu2004" 
domain_name = "home"
#Ignored the following 4 lines if DHCP used
vm_ip = "192.168.2.253"
vm_cidr = 23
default_gw = "192.168.2.1"
name_servers = "192.168.2.2,192.168.2.1"

vcpu_count = 1
memory = 1024
