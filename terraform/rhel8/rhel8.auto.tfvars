#https://www.virtjunkie.com/vmware-provisioning-using-hashicorp-terraform/
#https://github.com/jonhowe/Virtjunkie.com/tree/master/Terraform

vsphere_server = "vcenter01.home"
vsphere_user = "administrator@vcenter01.home"
vsphere_password = "P@ssw0rd"
adminpassword = "terraform" 
datacenter = "Datacenter"
datastore = "datastore2" 
cluster = "Cluster"
portgroup = "Non-OCP" 
domain_name = "home"
default_gw = "192.168.2.1" 
template_name = "tpl_rhel8" 
vm_name = "rhel8-test" 
vm_ip = ""
vm_cidr = 24
vcpu_count = 2
memory = 4096

#vcenter_server="vcenter01.home"
#vsphere_username="administrator@vcenter01.home"
#vsphere_password="P@ssw0rd"
#datastore="datastore2"
#host="esxhost01.home"
#datacenter="Datacenter"
#folder="Templates"
#cluster="Cluster"
#network="Non-OCP"
#boot_wait="5s"
#boot_iso="[datastore2] ISOs/rhel-8.4-x86_64-dvd.iso"
#guest_os_type="rhel8_64Guest"
#memsize="4096"
#numvcpus="2"
#disk_size="61440"
#ssh_password="server"
#ssh_username="root"
#vm_name="tpl_rhel8"
#kickstart_config="ks.cfg"