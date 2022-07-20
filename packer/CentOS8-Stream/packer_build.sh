#!/bin/bash

# This script is used to start the Packer build process
clear

# Export the variables to make them available to scripts
set -a

# Set the Script Dir
SCRIPT_PATH=`readlink -f "$0"`
SCRIPT_DIR=`dirname "$SCRIPT_PATH"`
#echo "SCRIPT_DIR = $SCRIPT_DIR"

# Set the Common Bin Dir
COMMON_BIN=${SCRIPT_DIR}/../../common/bin

# Set the Common Scripts Dir
COMMON_SCRIPTS=${SCRIPT_DIR}/../../common/scripts

# Set the Environment
source ${COMMON_SCRIPTS}/set_env.sh

# Setup the ISO Tool
$COMMON_SCRIPTS/setup_iso_tool.sh

# Set the ISO Tool Bin Dir
ISO_TOOL_BIN=$COMMON_BIN/$ISO_TOOL

# Setup the Path to Packer and MKISOFS
export PATH=$PATH:${PACKER_PATH}:${COMMON_BIN}:${ISO_TOOL_BIN}
#echo "PATH = $PATH"

# Check Environment Variables
# Check vSphere Username
if [ -z "${PKR_VAR_vsphere_username}" ] 
then
    echo "Enter vSphere Username - e.g. domain\\\username"
    read PKR_VAR_vsphere_username
    export PKR_VAR_vsphere_username
    echo ""
fi
# Check vSphere Password
if [ -z "${PKR_VAR_vsphere_password}" ] 
then
    echo "Enter vSphere Password - e.g. if \\ exists use \\\\"
    read PKR_VAR_vsphere_password
    export PKR_VAR_vsphere_password
    echo ""
fi

# Start the Packer Init Process
packer init .

# Start the Packer Build Process
packer build -force .

# Cleanup
${COMMON_SCRIPTS}/cleanup.sh