#config.pkr.hcl

packer {
  required_plugins {
    vsphere = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/vsphere"
    }
    #SSHKey
    sshkey = {
      version = ">= 1.0.1"
      source = "github.com/ivoronin/sshkey"
    }
  }
}
