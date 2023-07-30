#!/bin/bash

# This script is used to start the Packer build process
clear

# Export the variables to make them available to scripts
set -a

# Set the Script Launch Dir
LAUNCH_PATH=`readlink -f "$0"`
LAUNCH_DIR=`dirname "$LAUNCH_PATH"`
#echo "LAUNCH_DIR = $LAUNCH_DIR"
#read x

# Set the Common Bin Dir
COMMON_BIN=${LAUNCH_DIR}/../../common/bin

# Set the Common Scripts Dir
COMMON_SCRIPTS=${LAUNCH_DIR}/../../common/scripts

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

# Packer Cache Directory
export PACKER_CACHE_DIR=${LAUNCH_DIR}/packer_cache

# Packer Debug Logging
if [ -e ${LAUNCH_DIR}/packer-log ]
then
    echo 'Removing Packer Log'
    rm -f ${LAUNCH_DIR}/packer-log
fi
export PACKER_LOG=1
export PACKER_LOG_PATH=${LAUNCH_DIR}/packer-log

# Output Date and Time
date

# Start the Packer Init Process
packer init .

# Start the Packer Build Process
packer build -only='prebuild.*' -force -on-error=ask .
packer build -only='linux.*' -force -on-error=ask .

# Cleanup
${COMMON_SCRIPTS}/cleanup.sh

# Output Date and Time
date