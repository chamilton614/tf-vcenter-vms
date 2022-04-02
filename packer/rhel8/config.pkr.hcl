#rhel8_config.pkr.hcl

packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.3"
      source = "github.com/hashicorp/vmware"
    }
  }
}
