# Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source

locals {
    timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "aws-rhel" {
    
  ssh_username     = var.ssh_username
  #ssh_password     = var.ssh_password
  #subnet_id         = "subnet-0eab4bee6941a26a3"
  #security_group_ids = ["sg-08ebe96c6ff846548"]
  ssh_timeout      = "30m"
  # VM Information
  ami_name         = "${var.vm_name}-${local.timestamp}"
  instance_type    = var.vm_instance_type
  #AWS VM Region
  region           = var.vm_region

  source_ami_filter {
      filters = {
          name                = "amzn2-ami-kernel-5.10-hvm-2.*.1-x86_64-gp2"
          root-device-type    = "ebs"
          virtualization-type = "hvm"
      }
      most_recent = true
      owners = ["amazon"]
  }
  
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  # use the `name` field to name a build in the logs.
  # For example this present config will display
  # "buildname.amazon-ebs.example-1" and "buildname.amazon-ebs.example-2"
  name = "linux"
  sources = ["source.amazon-ebs.aws-rhel"]

  #provisioner "shell" {
  #    inline = ["echo Connected via SSH at '${build.User}@${build.Host}:${build.Port}'"]
  #}
  #
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
  #provisioner "shell" {
  #  only = ["vsphere-iso.rhel"]
  #  execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{ .Path }}'"
  #  scripts = [
  #    "package/scripts/cleanup.sh"
  #  ]
  #}
  #
}
