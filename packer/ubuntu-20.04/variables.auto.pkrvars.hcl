#Auto variables for Packer

vcenter_server="vcenter01.home"
#vsphere_username=""
#vsphere_password=""
datastore="datastore2"
host="esxhost01.home"
datacenter="Datacenter"
folder="Templates"
cluster="Cluster"
network="Non-OCP"
boot_wait="5s"
boot_iso="[datastore2] ISOs/Ubuntu/ubuntu-20.04.4-live-server-amd64.iso"
guest_os_type="ubuntu64Guest"
memsize="4096"
numvcpus="2"
disk_size="61440"
ssh_password="Welcome123"
ssh_username="ubuntu"
vm_name="tpl_ubuntu_2004"
seed_config=""