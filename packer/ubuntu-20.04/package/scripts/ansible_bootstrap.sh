#!/bin/bash -eux

echo "ansible_bootstrap.sh"

# Output Date and Time
date

#execute ansible bootstrap playbook
ansible-playbook bootstrap.yaml

# Output Date and Time
date