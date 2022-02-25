# Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source

source "null" "pre-build" {
  communicator = "none"
}

source "vsphere-iso" "rhel" {
  CPUs            = "${var.numvcpus}"
  CPU_hot_plug    = true
  RAM             = "${var.memsize}"
  RAM_hot_plug    = true
  RAM_reserve_all = false
  boot_command = [
    #"<tab> inst.text inst.ks=cdrom:/dev/sr1:/${var.kickstart_config} <enter>"
    # Workaround to use Packer as a local webserver since RHEL8 removed Floppy drivers, could use CD paths but this works easily
    "<up><wait><tab><wait> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/scripts/ks.cfg<enter><wait>"
  ]
  boot_order = "disk,cdrom,floppy"
  boot_wait  = "${var.boot_wait}"
  #cd_files             = ["./${var.kickstart_config}"]
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
  #Use iso_paths for Datastores
  #iso_paths            = ["${var.boot_iso}"]
  iso_url              = "${var.boot_iso}"
  iso_checksum         = "${var.boot_iso_checksum}"

  network_adapters {
    network      = "${var.network}"
    network_card = "vmxnet3"
  }

  notes            = "Built via Packer ${legacy_isotime("2022-02-03 00:00:00")}"
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
  http_directory = "package"
}

locals {
  checksum = ""
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {

  # Update the Name field in the build logs
  name    = "template"

  # use the `name` field to name a build in the logs.
  # For example this present config will display
  # "buildname.amazon-ebs.example-1" and "buildname.amazon-ebs.example-2"
  
  #source "source.null.pre-build" {}

  source "source.vsphere-iso.rhel" {
    name    = "rhel8"
  }

  #sources = ["source.null.pre-build","source.vsphere-iso.rhel"]

  #provisioner "shell-local" {
  #  only = ["null.pre-build"]
  #  inline = [
  #    "export checksum = cat ${var.boot_iso_checksum}",
  #    #"export CHECKSUM=$(pwd)",
  #    #"export CHECKSUM=$(cat {{user 'pwd'}}/'${var.boot_iso_checksum}')",
  #    #"echo $CHECKSUM"
  #    "echo $checksum"
  #  ]
  #}

  #Execute Additional Package scripts
  /* provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash -eux '{{ .Path }}'" # This runs the scripts with sudo
    scripts = [
      "scripts/package_updates.sh"
    ]
  } */

  #Final Customizations
  /* provisioner "ansible-local" {
    playbook_file = "scripts/setup.yml"
  } */

  #Execute Cleanup
  provisioner "shell" {
    only = ["vsphere-iso.rhel8"]
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "package/scripts/cleanup.sh"
    ]
  }

}
