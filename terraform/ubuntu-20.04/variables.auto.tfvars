#Auto variables for Terraform

#https://www.virtjunkie.com/vmware-provisioning-using-hashicorp-terraform/
#https://github.com/jonhowe/Virtjunkie.com/tree/master/Terraform

# vSphere/vCenter Variables
vsphere_server                 = "vcenter01.home"
#vsphere_username              = ""
#vsphere_password              = ""
insecure_connection            = true
datastore                      = "datastore2"
host                           = "esxhost01.home"
datacenter                     = "Datacenter"
folder                         = "Templates"
cluster                        = "Cluster"

# Virtual Machine Variables
adminpassword                  = "P@ssw0rd"
network                        = "Non-OCP" 

template_name                  = "pkr_tmpl_ubuntu2004_100GB"
vm_name                        = "ubuntu2004" 
domain_name                    = "home"

#Ignored the following 4 lines if DHCP used
vm_ip                          = "192.168.2.253"
vm_cidr                        = 23
default_gw                     = "192.168.2.1"
name_servers                   = ["192.168.2.2", "192.168.2.1"]

num_cpu_sockets                = 1
num_cpu_cores                  = 2
memory                         = 4096
