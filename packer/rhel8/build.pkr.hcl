
# Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vmware-iso" "rhel" {
  cpus                 = var.numvcpus
  memory               = var.memsize
  cores                = var.numvcpucores
  
  # ISO Configuration
  iso_urls              = [var.boot_iso]
  #iso_checksum         = "${var.boot_iso_checksum}"
  iso_checksum         = "${file(var.boot_iso_checksum)}"
  #Use iso_paths for Datastores
  #iso_paths            = ["${var.boot_iso}"]

  # Specify a network type
  network      = var.network

  boot_command         = [
    #"<tab> inst.text inst.ks=cdrom:/dev/sr1:/${var.kickstart_config} <enter>"
    # Workaround to use Packer as a local webserver since RHEL8 removed Floppy drivers, could use CD paths but this works easily
    #"<up><wait><tab><wait> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
    "<up><wait><tab><wait> inst.text inst.ks=cdrom<enter><wait>"
  ]
  #boot_order           = "disk,cdrom,floppy"
  boot_wait            = "${var.boot_wait}"
  #floppy_dirs         = ["./package/scripts/"]
  cdrom_adapter_type   = "sata"
  cd_files             = ["./package/scripts/*"]
  cd_label             = "cidata"
  #cluster              = "${var.cluster}"
  #convert_to_template  = "true"
  #create_snapshot      = "true"
  #datacenter           = "${var.datacenter}"
  #datastore            = "${var.datastore}"
  #folder               = "${var.folder}"
  output_directory     = "./output"
  guest_os_type        = "${var.guest_os_type}"
  #insecure_connection  = "true"
    
  notes            = "Built via Packer ${timestamp()}"
  #remove_cdrom     = "true"
  #resource_pool    = ""
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = var.ssh_username

  # Disk Controller - add another disk controller to separate drives if required and then update to appropriate index
  disk_adapter_type = "nvme"
  # Storage Disks
  #storage {
  disk_size             = var.disk_size_primary
  #  disk_controller_index = 0
  #  disk_thin_provisioned = true
  #}
  # Uncomment this section if Secondary Drive is needed
  #storage {
  #  disk_size             = "${var.disk_size_secondary}"
  #  disk_controller_index = 0
  #  disk_thin_provisioned = true
  #}
  
  # VM Information
  vm_name        = var.vm_name
  # vm_version if unset, defaults to most current VM hardware version supported
  # vm_version = 15
  # Use http_directory if allowing VM to connect to local packer http directory to read scripts
  #http_directory = "package"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  # use the `name` field to name a build in the logs.
  # For example this present config will display
  # "buildname.amazon-ebs.example-1" and "buildname.amazon-ebs.example-2"
  name = "template"
  sources = ["source.vmware-iso.rhel"]

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
    only = ["vmware-iso.rhel"]
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "package/scripts/cleanup.sh"
    ]
  }

}
