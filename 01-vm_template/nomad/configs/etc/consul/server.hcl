server = true
client_addr = "0.0.0.0"
advertise_addr = ""
advertise_addr_wan = ""
bind_addr = "{{GetInterfaceIP \"ens18\"}}"
bootstrap_expect = 3
data_dir = "/var/consul"
datacenter = "home"
enable_syslog = true
log_level = "WARN"
retry_join = ["192.168.1.11", "192.168.1.12", "192.168.1.13"]

ui_config {
  enabled = true
}
