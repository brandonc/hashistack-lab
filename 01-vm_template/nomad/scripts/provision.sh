#!/usr/bin/env bash

set -e

DEBIAN_FRONTEND=noninteractive

# Copy config
sudo mkdir -p /var/consul /etc/consul
sudo cp /tmp/configs/etc/consul/* /etc/consul/

sudo mkdir -p /var/nomad /etc/nomad
sudo cp /tmp/configs/etc/nomad/* /etc/nomad/

# Copy systemd files
sudo cp /tmp/configs/etc/systemd/system/* /etc/systemd/system/

sudo truncate -s 0 /etc/machine-id /var/lib/dbus/machine-id
