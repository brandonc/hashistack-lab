#!/usr/bin/env bash

set -e

DEBIAN_FRONTEND=noninteractive

# Install docker
sudo apt-get remove docker docker.io containerd runc
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# Rename nomad file & remove unused
sudo rm /etc/nomad/server.hcl
sudo mv /etc/nomad/client.hcl /etc/nomad/nomad.hcl

# Reload systemctl services
sudo systemctl daemon-reload

sudo systemctl enable consul
sudo systemctl enable nomad
