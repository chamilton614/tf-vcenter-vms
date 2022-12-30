
###############################
# vCenter Variables
###############################

variable "vcenter_server" {
    type = string
    description = "vcenter server"
}

variable "vsphere_username" {
    type = string
    description = "vcenter username"
    default = ""
    sensitive = true
}

variable "vsphere_password" {
    type = string
    description = "vcenter password"
    default = ""
    sensitive = true
}

variable "insecure_connection" {
    type = bool
    description = "Check to validate vCenter's TLS Certificate"
}

variable "datastore" {
    type = string
    description = "vcenter datastore"
}

variable "host" {
    type = string
    description = "vcenter host"
}

variable "datacenter" {
    type = string
    description = "vcenter datacenter name"
}

variable "folder" {
    type = string
    description = "folder for the templates"
    default = "Templates"
}

variable "cluster" {
    type = string
    description = "vcenter cluster name"
}

###############################
# Virtual Machine Variables
###############################

variable "template_vm_name" {
    type = string
    description = "name of the vm template"
}

variable "guest_os_type" {
    type = string
    description = "os type name in vmware"
}

variable "hardware_version" {
    type = number
    description = "hardware version of the vm"
}

variable "firmware" {
    type = string
    description = "firmware type to use bios or efi"
}

variable "convert_to_template" {
    type = bool
    description = "convert the vm to a template"
}

variable "create_snapshot" {
    type = bool
    description = "create a vm snapshot for the template"
}

variable "cdrom_type" {
    type = string
    description = "cdrom type to use sata or scsi"
}

variable "num_cpu_sockets" {
    type = number
    description = "number of cpu sockets to include"
}

variable "num_cpu_cores" {
    type = number
    description = "number of cpu cores to include"
}

variable "memsize" {
    type = number
    description = "size of memory for the vm"
}

variable "disk_size" {
    type = number
    description = "size of the disk for the vm"
}

variable "thin_provisioned" {
    type = bool
    description = "thin or thick provisioning of the disk"
}

variable "disk_eagerly_scrub" {
  type = bool
  description = "eagerly scrub zeros"
  default = false
}

variable "disk_controller_type" {
  type = list(string)
  description = "The virtual disk controller types"
}

variable "network_card" {
    type = string
    description = "network card type"
}

variable "network" {
    type = string
    description = "vcenter network for the vm"
}

variable "boot_wait" {
    type = string
    description = "bootup wait time"
}

variable "iso_paths" {
    type = list(string)
    description = "boot iso to use"
}

variable "ssh_username" {
    type = string
    description = "ssh login username for post-install"
}

variable "ssh_password" {
    type = string
    description = "ssh login password for post-install"
}

#variable "ssh_public_key" {
#  type        = string
#  description = "Public key for ssh user to be used to ssh into a machine"
#  #default     = "AAAAB3NzaC1yc2EAAAADAQABAAABAQCb7fcDZfIG+SxuP5UsZaoHPdh9MNxtEL5xRI71hzMS5h4SsZiPGEP4shLcF9YxSncdOJpyOJ6OgumNSFWj2pCd/kqg9wQzk/E1o+FRMbWX5gX8xMzPig8mmKkW5szhnP+yYYYuGUqvTAKX4ua1mQwL6PipWKYJ1huJhgpGHrvSQ6kuywJ23hw4klcaiZKXVYtvTi8pqZHhE5Kx1237a/6GRwnbGLEp0UR2Q/KPf6yRgZIrCdD+AtOznSBsBhf5vqcfnnwEIC/DOnqcOTahBVtFhOKuPSv3bUikAD4Vw7SIRteMltUVkd/O341fx+diKOBY7a8M6pn81HEZEmGsr7rT sam@SamMac.local"
#}


###############################
# Script Configurations
###############################

variable "scripts_directory" {
    type = string
    description = "scripts directory for installation"
}

variable "install_scripts" {
    type = list(string)
    description = "list of scripts to run"
}

variable "packer_cache" {
    #type = string
    description = "Used to store temporary files"
    default = env("PACKER_CACHE_DIR")
}

variable "launch_home" {
    description = "This is the root path for this packer build"
    default = env("LAUNCH_DIR")
}

###############################
# Variables not used often
###############################

variable "content_library_destination" {
   type = string
   default =   "Images"
}

variable "library_vm_destroy" {
   type = bool
   default = true
}

variable "ovf_template" {
    type = bool
    default = true
}






