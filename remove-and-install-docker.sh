#!/usr/bin/env bash
# uninstall
sudo apt-get purge docker-ce -y

# delete remaining data
sudo rm -rf /mnt/data/builder/
sudo rm -rf /mnt/data/buildkit
sudo rm -rf /mnt/data/containerd
sudo rm -rf /mnt/data/containers
sudo rm -rf /mnt/data/image
sudo rm -rf /mnt/data/network
sudo rm -rf /mnt/data/overlay2
sudo rm -rf /mnt/data/plugins
sudo rm -rf /mnt/data/runtimes
sudo rm -rf /mnt/data/swarm
sudo rm -rf /mnt/data/tmp
sudo rm -rf /mnt/data/trust
sudo rm -rf /mnt/data/volumes

# install
export VERSION=18.06.1
sudo curl -sSL https://get.docker.com | sh
sudo usermod -a -G docker casa
sudo systemctl stop docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# Force docker.socket to start only after hdd mount
sudo sed -i '/PartOf=docker.service/a After=mnt-data.mount' /lib/systemd/system/docker.socket

# start Casa Node
sudo systemctl enable casa.service

# reboot to start casa services
sudo reboot
