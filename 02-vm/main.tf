terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "${var.proxmox_url}/api2/json"
  pm_tls_insecure = true
}

locals {
  node = "hype"
  # These are created by packer in the 01-vm_template step
  template_server = "nomad-server"
  template_client = "nomad-client"
}

resource "proxmox_vm_qemu" "nomad-server" {
  clone       = local.template_server
  target_node = local.node
  onboot      = true
  oncreate    = true
  vmid        = 110+count.index
  desc        = "Managed by Terraform"
  name        = "nomad-server${count.index+1}.lab"
  scsihw      = "lsi"
  memory      = 2048
  agent       = 1
  define_connection_info = true

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  count       = 3

  provisioner "file" {
    source      = "netplan/static_ip_server${count.index+1}.yaml"
    destination = "/tmp/00-installer-config.yaml"

    connection {
      type     = "ssh"
      user     = "brandonc"
      password = "brandonc"
      host        = "${self.ssh_host}"
      port        = "${self.ssh_port}"
    }
  }

  connection {
    type     = "ssh"
    user     = "brandonc"
    password = "brandonc"
    host        = "${self.ssh_host}"
    port        = "${self.ssh_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/00-installer-config.yaml /etc/netplan/",
      "sudo netplan apply",
      "sudo hostnamectl set-hostname nomad-server${count.index+1}",
      "sudo shutdown -r `date --date \"now + 2 seconds\"`"
    ]
  }
}

resource "proxmox_vm_qemu" "nomad-client" {
  clone       = local.template_client
  target_node = local.node
  onboot      = true
  oncreate    = true
  vmid        = 113+count.index
  desc        = "Managed by Terraform"
  name        = "nomad-client${count.index+1}.lab"
  scsihw      = "lsi"
  memory      = 32768
  agent       = 1
  define_connection_info = true

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  count       = 3

  connection {
    type     = "ssh"
    user     = "brandonc"
    password = "brandonc"
    host        = "${self.ssh_host}"
    port        = "${self.ssh_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname nomad-client${count.index+1}",
      "sleep 10 & sudo shutdown -r `date --date \"now + 2 seconds\"`&",
      "exit 0"
    ]
  }
}
