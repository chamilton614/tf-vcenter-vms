# Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "ubuntu" {
  CPUs                 = "${var.numvcpus}"
  CPU_hot_plug         = true
  RAM                  = "${var.memsize}"
  RAM_hot_plug         = true
  RAM_reserve_all      = false
  boot_command         = [
    "<enter><enter><f6><esc><wait> ",
    "autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "<enter>"
  ]
  boot_order           = "disk,cdrom,floppy"
  boot_wait            = "${var.boot_wait}"
  #cd_files             = ["./${var.install_config}"]
  #cd_label             = "OEMDRV"
  cluster              = "${var.cluster}"
  convert_to_template  = "true"
  create_snapshot      = "true"
  datacenter           = "${var.datacenter}"
  datastore            = "${var.datastore}"
  disk_controller_type = ["pvscsi"]
  folder               = "${var.folder}"
  guest_os_type        = "${var.guest_os_type}"
  insecure_connection  = "true"
  iso_paths            = ["${var.boot_iso}"]
  network_adapters {
    network      = "${var.network}"
    network_card = "vmxnet3"
  }
  notes            = "Built via Packer ${timestamp()}"
  password         = "${var.vsphere_password}"
  remove_cdrom     = "true"
  resource_pool    = ""
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  storage {
    disk_size             = "${var.disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vsphere_username}"
  vcenter_server = "${var.vcenter_server}"
  vm_name        = "${var.vm_name}"
  http_directory = "package/scripts"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  # use the `name` field to name a build in the logs.
  # For example this present config will display
  # "buildname.amazon-ebs.example-1" and "buildname.amazon-ebs.example-2"
  name = "linux"
  sources = ["source.vsphere-iso.ubuntu"]

  #Execute Additional Package scripts
  #provisioner "shell" {
  #  execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash -eux '{{ .Path }}'" # This runs the scripts with sudo
  #  scripts = [
  #    "package/scripts/package_updates.sh",
  #    "package/scripts/cockpit.sh"
  #  ]
  #}

  #Final Customizations
  #provisioner "ansible-local" {
  #  playbook_file = "package/scripts/setup.yml"
  #}

  #Execute Cleanup
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "package/scripts/cleanup.sh"
    ]
  }

}
