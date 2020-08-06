#!/bin/bash
#update package repository
apt-get update
apt install -y curl jq
#install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
#get latest image
VERSION=$(curl --silent https://registry.hub.docker.com/v1/repositories/"vixenpi/secret-website"/tags | jq --raw-output '.[].name' | tail -n 1)
echo "Found version ${VERSION}"
docker run --name "secret-website" -p 80:80 -d --restart always vixenpi/secret-website:${VERSION}
