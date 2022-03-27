# Packer

## RHEL8
This will create a RHEL 8 Packer Image into a VMWare Template
Requirements:
 - Packer installed
 - This Repo Cloned locally
 - User Credentials to vSphere
 - VM Network to use
 - Temporary IP Information - ip, subnet mask, gateway

1. Clone this [Repo](https://github.com/chamilton614/tf-vcenter-vms.git)
2. Browse to the packer/rhel8 directory
3. Update variables.auto.pkrvars.hcl
4. Run packer_build.sh