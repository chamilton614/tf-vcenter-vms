#!/bin/bash

# Use this script to source all of your variables that are common for this repository to be sourced when needed

# Set the Packer Path to the Binary
PACKER_PATH=/usr/bin/packer

# Set the Terraform Path to the Binary
TERRAFORM_PATH=/usr/bin/terraform

# Set the ISO TOOL
ISO_TOOL=mkisofs
ISO_TOOL_FILE=mkisofs-2.01.zip

# Terraform Troubleshooting Variables - USE WITH CAUTION
#VSPHERE_CLIENT_DEBUG=true
#VSPHERE_CLIENT_DEBUG_PATH=$(pwd)/.govmomi
#VSPHERE_CLIENT_DEBUG_PATH_RUN=RUN

