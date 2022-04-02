# Declared variables.

variable "network" {
    type = string
    description = "network type for the vm"
    # Default value is formality for auto vars.  Do not remove
    default = ""
}

variable "boot_wait" {
    type = string
    description = "bootup wait time"
}

variable "boot_iso" {
    type = string
    description = "boot iso to use"
}

variable "boot_iso_checksum" {
    type        = string
    description = "boot iso checksum to use"
}

variable "guest_os_type" {
    type = string
    description = "os type name in vmware"
}

variable "memsize" {
    type = int
    description = "size of memory for the vm"
}

variable "numvcpus" {
    type = int
    description = "number of cpus for the vm"
}

variable "numvcpucores" {
    type = int
    description = "number of cpu cores for the vm"
}

variable "disk_size_primary" {
    type = uint
    description = "size of the primary disk for the vm"
}

variable "disk_size_secondary" {
    type = uint
    description = "size of the secondary disk for the vm"
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

variable "kickstart_config" {
    type = string
    description = "name of the kickstart file"
}

