# Declared variables.
variable "vcenter_server" {
    type = string
    description = "vcenter server"
}

variable "vsphere_username" {
    type = string
    description = "vcenter username"
    sensitive = true
}

variable "vsphere_password" {
    type = string
    description = "vcenter password"
    sensitive = true
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

variable "network" {
    type = string
    description = "vcenter network for the vm"
}

variable "boot_wait" {
    type = string
    description = "bootup wait time"
}

variable "boot_iso" {
    type = string
    description = "boot iso to use"
}

variable "guest_os_type" {
    type = string
    description = "os type name in vmware"
}

variable "memsize" {
    type = string
    description = "size of memory for the vm"
}

variable "numvcpus" {
    type = string
    description = "number of cpus for the vm"
}

variable "disk_size" {
    type = string
    description = "size of the disk for the vm"
}

variable "ssh_password" {
    type = string
    description = "ssh login password for post-install"
}

variable "ssh_username" {
    type = string
    description = "ssh login username for post-install"
}

variable "vm_name" {
    type = string
    description = "name of the vm"
}

variable "content_library_destination" {
   type = string
   default =   "Images"
}

variable "template_library_name" {
    type = string
    description = "name of the vm template"
}

variable "library_vm_destroy" {
   type = bool
   default = true
}

variable "install_config" {
    type = string
    description = "name of the install file"
}

