#https://www.virtjunkie.com/vmware-provisioning-using-hashicorp-terraform/
#https://github.com/jonhowe/Virtjunkie.com/tree/master/Terraform

vsphere_server = "SDCpiinfvc3.white.aim.local"
#vsphere_user = "domain\\user"
#vsphere_password = "somepassword"

adminpassword = "packer" 
datacenter = "SDC-NPD-DC"
datastore = "SDC-NPD-vsan" 
cluster = "SDC-NPD"
network = "wht-lnx-infra-npd" 

template_name = "tpl_rhel8"
vm_name = "tpl-rhel8-test" 
domain_name = "localdomain"
vm_ip = "10.17.39.13"
vm_cidr = 24
default_gw = "10.17.39.1"
name_servers = "172.16.124.26,172.16.124.27,172.25.16.22"

vcpu_count = 2
memory = 4096
