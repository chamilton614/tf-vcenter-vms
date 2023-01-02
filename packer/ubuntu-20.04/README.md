# Ubuntu 20.04
The files in this folder will be used to create a packer template for the titled OS.  The packer related files have been broken out separately so a user can understand how these work together to create the template.  Each packer file has been properly named by the extensions so they can be easily recognized by packer.  For example, the variables.auto.pkrvars.hcl tells Packer that these variables should be loaded with these values.

The following template will be created:
 - Ubuntu 20.04

Requirements:
 - Linux System to run these scripts
 - Min. Packer 1.8.5 installed
 - This Repo cloned locally
 - User Credentials to vSphere that can create VM Templates
 - VM Network to use
 - Temporary IP Information if NOT using DHCP - ip, subnet mask, gateway

Quick Start:
1. Clone this Repo
2. Update variables.auto.pkrvars.hcl as needed
3. Run packer_build.sh

Testing:
 - These scripts have been tested with Packer 1.8.5 from a Ubuntu Desktop running version 20.04 and from a MacBook running Ventura 13.1