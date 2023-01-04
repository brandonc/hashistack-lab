#!/usr/bin/env bash

set -e

DEBIAN_FRONTEND=noninteractive

# Rename nomad file & remove unused
sudo rm /etc/nomad/client.hcl
sudo mv /etc/nomad/server.hcl /etc/nomad/nomad.hcl

# Reload systemctl services
sudo systemctl daemon-reload

sudo systemctl enable consul
sudo systemctl enable nomad
