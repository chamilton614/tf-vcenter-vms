[master]
ansible_tmp_host
#ansible_tmp_host ansible_host=ansible_tmp_host ansible_user=ansible_tmp_user ansible_port=22

[master:vars]
ansible_ssh_user=ansible_tmp_user
ansible_ssh_pass=ansible_tmp_password
