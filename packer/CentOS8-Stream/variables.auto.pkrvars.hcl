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
boot_iso="[datastore2] ISOs/CentOS/CentOS-Stream-8-x86_64-latest-dvd1.iso"
guest_os_type="centos8_64Guest"
memsize="4096"
numvcpus="2"
disk_size="61440"
ssh_password="server"
ssh_username="root"
vm_name="tpl_centos-stream8"
install_config="ks.cfg"