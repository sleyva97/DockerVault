#!/bin/bash
#

# Bootstrap consul and vault
export VAULT_ADDR='http://127.0.0.1:8200'
nohup consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -bind 0.0.0.0 > /var/log/consul.log &
nohup vault server -config=/etc/config.hcl > /var/log/vault.log &

# Initialize and unseal vault in an automated way
# !!!! Not recommended for production !!!!
vault init -key-shares=5 -key-threshold=3 > keys.txt
vault unseal -address=${VAULT_ADDR} $(grep 'Key 1:' keys.txt | awk '{print $NF}')
vault unseal -address=${VAULT_ADDR} $(grep 'Key 2:' keys.txt | awk '{print $NF}')
vault unseal -address=${VAULT_ADDR} $(grep 'Key 3:' keys.txt | awk '{print $NF}')

# Enable login
export VAULT_TOKEN=$(grep 'Initial Root Token:' keys.txt | awk '{print substr($NF, 1, length($NF)-1)}')
echo $VAULT_TOKEN

# Tail the Vault log
tail -f /var/log/vault.log
