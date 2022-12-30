#!/bin/bash -eux

echo "create_ansible_inventory_ini.sh"

# Output Date and Time
date

#FILENAME=$1
#ORIGINAL_STRING=$2
#NEW_STRING=$3
#
#if [ $# -ne 3 ]; then
#    echo "The required number of arguments were not passed into this script"
#    exit 1
#fi

#Make a copy of the inventory template to create inventory.ini
echo "cp ${ansible_inv_template_file} ${ansible_inv_file}"
cp ${ansible_inv_template_file} ${ansible_inv_file}

#Get the IP from the Guest IP file
ansible_inv_host=$(cat ${ansible_inv_host_file})

#Replace default
echo "sed -i'' -e 's/default/${ansible_inv_host}/g' ${ansible_inv_file}"
sed -i'' -e "s/default/${ansible_inv_host}/g" "${ansible_inv_file}"

#Replace HOST
echo "sed -i'' -e 's/ansible_tmp_host/${ansible_inv_host}/g' ${ansible_inv_file}"
sed -i'' -e "s/ansible_tmp_host/${ansible_inv_host}/g" "${ansible_inv_file}"

#Replace USER
echo "sed -i'' -e 's/ansible_tmp_user/${ansible_inv_user}/g' ${ansible_inv_file}"
sed -i'' -e "s/ansible_tmp_user/${ansible_inv_user}/g" ${ansible_inv_file}

# Output Date and Time
date
