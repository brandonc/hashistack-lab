terraform {
  cloud {
    organization = "bcroft"

    workspaces {
      name = "homelab-infra-02-vm"
    }
  }
}
