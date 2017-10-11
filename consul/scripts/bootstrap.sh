#!/bin/bash
#

# Bootstrap consul and vault
export VAULT_ADDR='http://127.0.0.1:8200'
consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -client 0.0.0.0 -bind 127.0.0.1
