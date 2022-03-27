#https://www.virtjunkie.com/vmware-provisioning-using-hashicorp-terraform/
#https://github.com/jonhowe/Virtjunkie.com/tree/master/Terraform

vsphere_server = "vcenter01.home"
#vsphere_user = "domain\\user"
#vsphere_password = "somepassword"

adminpassword = "packer" 
datacenter = "Datacenter"
datastore = "datastore2" 
cluster = "Cluster"
network = "Non-OCP" 

template_name = "tpl_rhel8"
vm_name = "tpl-rhel8-test" 
domain_name = "home"
#Ignored the following 4 lines if DHCP used
vm_ip = "192.168.2.253"
vm_cidr = 24
default_gw = "192.168.2.1"
name_servers = "192.168.2.1,1.1.1.1"

vcpu_count = 2
memory = 4096
