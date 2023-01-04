data_dir = "/var/nomad/"

bind_addr = "0.0.0.0"

datacenter = "dc1"
region = "lab"
log_level = "warn"

server {
  enabled = true
  authoritative_region = "lab"
  bootstrap_expect = 3
  heartbeat_grace = "300s"
  min_heartbeat_ttl = "20s"
}

acl {
  enabled = false
}

consul {
  address = "127.0.0.1:8500"
  client_service_name = "nomad-server"
  auto_advertise = true
  server_auto_join = true
  client_auto_join = true
}
