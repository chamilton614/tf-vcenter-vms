# Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source

data "sshkey" "install" {
  name = var.ssh_username
  type = "ed25519"
}

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  serverbuildtime = formatdate("YYYYMMDDhhmmss", timestamp())
  packer_cache = var.packer_cache
  ssh_public_key = data.sshkey.install.public_key
  ssh_public_key_file = "${var.scripts_directory}/id_ed25519_${var.ssh_username}.pub"
  ssh_private_key_temp_file = "packer_cache/ssh_private_key_${var.ssh_username}_ed25519.pem"
  ssh_private_key_file = "${var.scripts_directory}/id_ed25519_${var.ssh_username}"
}

source "file" "ssh-public-key-file" {
  content = local.ssh_public_key
  target = local.ssh_public_key_file
}

source "file" "ssh-private-key-file" {
  source = local.ssh_private_key_temp_file
  target = local.ssh_private_key_file
}

source "file" "install-config-file" {
  content = templatefile("${var.scripts_directory}/ks-cfg.pkrtpl.hcl", {
    ssh_public_key = local.ssh_public_key,
    serverbuildtime = local.serverbuildtime
  })
  target = "${var.scripts_directory}/ks.cfg"
}

source "file" "install-ansible-config-file" {
  content = templatefile("${var.scripts_directory}/ansible.cfg.pkrtpl.hcl", {
    ssh_username = var.ssh_username
  })
  target = "${var.scripts_directory}/ansible.cfg"
}

#source "null" "example1" {
#  communicator = "none"
#}

source "vsphere-iso" "centos-stream" {
  CPUs                 = var.num_cpu_sockets
  cpu_cores            = var.num_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.memsize
  RAM_hot_plug         = false
  RAM_reserve_all      = false
  boot_command         = [
    #"<tab> inst.text inst.ks=cdrom:/dev/sr1:/${var.install_config} <enter>"
    # Workaround to use Packer as a local webserver since RHEL8 removed Floppy drivers, could use CD paths but this works easily
    "<up><wait><tab><wait> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
  ]
  boot_order           = "disk,cdrom,floppy"
  boot_wait            = var.boot_wait
  #cd_files             = ["./${var.install_config}"]
  #cd_label             = "OEMDRV"
  cluster              = var.cluster

  # Used to store VM Templates in a vCenter Content Library
  # Uncomment this section to use a Content Library
  #content_library_destination {
  #  destroy = var.library_vm_destroy
  #  library = var.content_library_destination
  #  name = var.template_vm_name
  #  ovf = var.ovf_template
  #}
  
  # Create Template - set to false if using a content library
  convert_to_template  = var.convert_to_template
  create_snapshot      = var.create_snapshot
  tools_upgrade_policy = true
  datacenter           = var.datacenter
  datastore            = var.datastore
  disk_controller_type = var.disk_controller_type
  folder               = var.folder
  guest_os_type        = var.guest_os_type
  vm_version           = var.hardware_version
  insecure_connection  = var.insecure_connection
  iso_paths            = var.iso_paths
  network_adapters {
    network      = var.network
    network_card = var.network_card
  }
  notes            = "Built via Packer ${local.buildtime}"
  password         = var.vsphere_password
  remove_cdrom     = true
  resource_pool    = ""
  #shutdown_command = "echo '${var.ssh_password}' | sudo -S /sbin/halt -h -p"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S -E shutdown -P now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = var.ssh_username
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.thin_provisioned
  }
  username       = var.vsphere_username
  vcenter_server = var.vcenter_server
  #vm_name        = var.template_vm_name}-${local.timestamp}
  vm_name        = var.template_vm_name
  http_directory = var.scripts_directory
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  name = "prebuild"
  sources = [
    "source.file.ssh-public-key-file",
    "source.file.ssh-private-key-file",
    "source.file.install-config-file",
    "source.file.install-ansible-config-file",
  ]
}

build {
  # use the `name` field to name a build in the logs.
  # For example this present config will display
  # "buildname.amazon-ebs.example-1" and "buildname.amazon-ebs.example-2"
  name = "linux"
  sources = [
    "source.vsphere-iso.centos-stream",
    #"source.null.example1",
  ]

  #Execute Remote Shell to get the Guest Build IP Address since the Template Variables do not work
  provisioner "shell" {
    inline = ["ip -4 -o a|cut -d' ' -f2,7|cut -d'/' -f1|grep et|cut -d' ' -f2> /tmp/guest_ip.txt"]
  }

  #Download the Guest IP Text file of the Guest Build since the Template Variables do not work
  provisioner "file" {
    source = "/tmp/guest_ip.txt"
    destination = "${var.scripts_directory}/guest_ip.txt"
    direction = "download"
  }

  #Create Ansible inventory.ini
  provisioner "shell-local" {
    environment_vars = [
      "ansible_inv_template_file=${var.scripts_directory}/inventory.ini.pkrtpl.hcl",
      "ansible_inv_file=${var.scripts_directory}/inventory.ini",
      "ansible_inv_guest_file=${var.scripts_directory}/guest_ip.txt",
      "ansible_inv_user=${var.ssh_username}",
      "ansible_inv_password=${var.ssh_password}",
    ]
    execute_command = ["bash", "-c", "{{.Vars}} {{.Script}}"]
    #use_linux_pathing = true
    script = "${var.scripts_directory}/create_ansible_inventory_ini.sh"
  }

  #Ansible Bootstrap using shell-local
  #Used this provisioner because the ansible provisioner always wanted to use ssh keys to connect even with custom options it never worked
  #This solution was much easier and cleaner to get the initial bootstrapping done so the node could be managed or at least ready to be. 
  provisioner "shell-local" {
    environment_vars = [
     "ansible_bootstrap_file=bootstrap.yaml",
    ]
    execute_command = ["bash", "-c", "{{.Vars}} {{.Script}}"]
    #use_linux_pathing = true
    script = "${var.scripts_directory}/ansible_bootstrap.sh" 
  }

  #Execute Cleanup
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.ssh_username}",
    ]
    scripts = var.install_scripts
    expect_disconnect = true
  }
}
