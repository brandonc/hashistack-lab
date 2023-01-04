terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.8.0"
    }
  }
}

provider "proxmox" {
  virtual_environment {
    endpoint = var.proxmox_url
    insecure = true
  }
}

resource "proxmox_virtual_environment_role" "packer" {
  role_id = "packer"

  privileges = [
    "VM.Allocate",
    "VM.Audit",
    "VM.Clone",
    "VM.Config.CDROM",
    "VM.Config.CPU",
    "VM.Config.Cloudinit",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Options",
    "VM.Console",
    "VM.Monitor",
    "VM.PowerMgmt",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.AllocateTemplate",
    "Datastore.Audit",
    "Sys.Modify"
  ]
}

resource "proxmox_virtual_environment_user" "packer" {
  acl {
    path = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.packer.role_id
  }

  comment  = "Managed by Terraform"
  password = random_password.packer.result
  user_id  = "packer@pve"
}

resource "random_password" "packer" {
  length           = 16
  special          = true
  override_special = "@-_"
}

output "proxmox_packer_password" {
  value = random_password.packer.result
  sensitive = true
}
