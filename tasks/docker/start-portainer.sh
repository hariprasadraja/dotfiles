#!/usr/bin/env bash

docker volume create portainer_data

docker run -d -p 9090:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

util log-success "PORTAINER" "RUNNING IN PORT:9090"
