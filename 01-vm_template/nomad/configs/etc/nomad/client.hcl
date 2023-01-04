bind_addr = "0.0.0.0"
data_dir = "/var/nomad/"
datacenter = "dc1"
region = "lab"
log_level = "warn"

acl {
  enabled = false
}

client {
  enabled = true
  network_interface = ""

  options = {
    docker.privileged.enabled = true
    docker.volumes.enabled = true
    docker.caps.whitelist = "ALL"
    driver.raw_exec.enable = "1"
  }
}

consul {
  address = "127.0.0.1:8500"
  client_service_name = "nomad-client"
  auto_advertise = true
  server_auto_join = true
  client_auto_join = true
}
