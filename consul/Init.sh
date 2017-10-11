#!/bin/bash
apt update -y
apt upgrade -y
apt install dumb-init

dir='src/github.com/hashicorp'
mkdir -p $dir
cd $dir

# Compile Consul
git clone https://github.com/hashicorp/consul.git
cd consul
make bootstrap
make dev
