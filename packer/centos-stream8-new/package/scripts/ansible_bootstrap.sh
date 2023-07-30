#!/bin/bash -eux

echo "ansible_bootstrap.sh"

# Output Date and Time
date

# Set the Script Launch Dir
LAUNCH_PATH=`readlink -f "$0"`
LAUNCH_DIR=`dirname "$LAUNCH_PATH"`
#echo "LAUNCH_PATH = ${LAUNCH_PATH}"
#echo "LAUNCH_DIR = ${LAUNCH_DIR}"

# Get the Callers Path
CPWD=$(pwd)
#echo "CPWD = ${CPWD}"

# Change to LaunchDir where scripts reside
cd ${LAUNCH_DIR}

# Check Parameters
if [ -z ${ansible_bootstrap_file+x} ];then
    #Default value if not set
    ansible_bootstrap_file=bootstrap.yaml
fi

#execute ansible bootstrap playbook
ansible-playbook ${ansible_bootstrap_file}

# Output Date and Time
date