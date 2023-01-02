# Ubuntu 20.04
This will create the following template:
 - Ubuntu 20.04

Requirements:
 - Linux System to run these scripts
 - Min. Packer 1.8.5 installed
 - This Repo cloned locally
 - User Credentials to vSphere that can create VM Templates
 - VM Network to use
 - Temporary IP Information if NOT using DHCP - ip, subnet mask, gateway
 
1. Clone this Repo
2. Update variables.auto.pkrvars.hcl as needed
4. Run packer_build.sh

Testing:
 - These scripts were tested with Packer 1.8.5 from a Ubuntu Desktop 20.04 and MacBook Ventura 13.1