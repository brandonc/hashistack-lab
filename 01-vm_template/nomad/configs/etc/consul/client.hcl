server = false
client_addr = "0.0.0.0"
advertise_addr = ""
advertise_addr_wan = ""
bind_addr = "{{GetInterfaceIP \"ens18\"}}"
data_dir = "/var/consul"
datacenter = "home"
enable_syslog = true
log_level = "WARN"

ui_config {
  enabled = true
}
