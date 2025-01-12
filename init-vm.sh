#!/bin/bash

sudo apt-get update
sudo apt-get install wget apt-transport-https gnupg ca-certificates curl jq
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key -o /etc/apt/keyrings/aquasecurity.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc /etc/apt/keyrings/aquasecurity.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo \
  "deb [signed-by=/etc/apt/keyrings/aquasecurity.asc] https://aquasecurity.github.io/trivy-repo/deb \
  $(. /etc/os-release && echo "$VERSION_CODENAME") main" | \
  sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo add-apt-repository ppa:cncf-buildpacks/pack-cli

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin pack-cli trivy

sudo groupadd docker || true
sudo usermod -aG docker $USER


