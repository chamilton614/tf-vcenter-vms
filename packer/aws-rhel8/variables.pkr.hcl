# Declared variables.

#variable "ssh_password" {
#    type = string
#    description = "ssh login password for post-install"
#}

variable "ssh_username" {
    type = string
    description = "ssh login username for post-install"
}

variable "vm_name" {
    type = string
    description = "name of the vm"
}

variable "vm_instance_type" {
    type = string
    description = "instance type of AWS EC2"
}

variable "vm_region" {
    type = string
    description = "AWS Region"
}
