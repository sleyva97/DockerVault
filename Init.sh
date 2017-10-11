#!/bin/bash
apt update -y
apt upgrade -y
apt install dumb-init

dir='src/github.com/hashicorp'
mkdir -p $dir
cd $dir

# Compile Vault
git clone https://github.com/hashicorp/vault.git
cd vault
make bootstrap
make dev

# Compile Consul
cd ../
git clone https://github.com/hashicorp/consul.git
cd consul
make bootstrap
make dev
