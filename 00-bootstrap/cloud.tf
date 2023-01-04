terraform {
  cloud {
    organization = "bcroft"

    workspaces {
      name = "homelab-infra-00-bootstrap"
    }
  }
}
