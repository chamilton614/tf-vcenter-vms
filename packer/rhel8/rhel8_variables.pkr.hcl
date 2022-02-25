# Declared variables.
variable "vcenter_server" {
  type        = string
  description = "vcenter server"
}

variable "vsphere_username" {
  type        = string
  description = "vcenter username"
}

variable "vsphere_password" {
  type        = string
  description = "vcenter password"
}

variable "datastore" {
  type        = string
  description = "vcenter datastore"
}

variable "host" {
  type        = string
  description = "vcenter host"
}

variable "datacenter" {
  type        = string
  description = "vcenter datacenter name"
}

variable "folder" {
  type        = string
  description = "folder for the templates"
}

variable "cluster" {
  type        = string
  description = "vcenter cluster name"
}

variable "network" {
  type        = string
  description = "vcenter network for the vm"
}

variable "boot_wait" {
  type        = string
  description = "bootup wait time"
}

variable "boot_iso" {
  type        = string
  description = "boot iso to use"
}

variable "boot_iso_checksum" {
  type        = string
  description = "boot iso checksum to use"
}

variable "guest_os_type" {
  type        = string
  description = "os type name in vmware"
}

variable "memsize" {
  type        = string
  description = "size of memory for the vm"
}

variable "numvcpus" {
  type        = string
  description = "number of cpus for the vm"
}

variable "disk_size" {
  type        = string
  description = "size of the disk for the vm"
}

variable "ssh_password" {
  type        = string
  description = "ssh login password for post-install"
}

variable "ssh_username" {
  type        = string
  description = "ssh login username for post-install"
}

variable "os_type" {
  type        = string
  description = "os type"
}

variable "os_version" {
  type        = string
  description = "os version"
}

variable "vm_name" {
  type        = string
  description = "name of the vm with os_type and os_version appended to it"
}

variable "kickstart_config" {
  type        = string
  description = "name of the kickstart file"
}

