#!/bin/bash
# !!! NOT FOR PRODUCTION !!!
# This is used with docker compose for to test integrity of our images

export VAULT_ADDR='http://127.0.0.1:8200'

if curl $VAULT_ADDR/v1/sys/init | grep false; then
    vault init -key-shares=5 -key-threshold=3 > keys_test.txt
fi

if [ -f keys_test.txt ]; then
    vault unseal -address="${VAULT_ADDR}" "$(grep 'Key 1:' keys_test.txt | awk '{print $NF}')"
    vault unseal -address="${VAULT_ADDR}" "$(grep 'Key 2:' keys_test.txt | awk '{print $NF}')"
    vault unseal -address="${VAULT_ADDR}" "$(grep 'Key 3:' keys_test.txt | awk '{print $NF}')"
    VAULT_TOKEN="$(grep 'Initial Root Token:' keys_test.txt | awk '{print substr($NF, 1, length($NF))}')"

    vault auth "$VAULT_TOKEN"

    if vault status | grep "Sealed: false"; then
        printf "%s\n" "The vault unsealed properly...Writing test secret"
        if vault write secret/hello value=world; then
            printf "%s\n" "Successfully wrote secret...Now trying to read it back"
        else
            printf "%s\n" "Secret Writing failed"
        fi
        if vault read -field=value secret/hello; then
            printf "%s\n" "....Successfully read secret"
            printf "%s\n" "Vault appears to be stable"
            printf "Test Complete\n"
        else
            printf "%s\n" "Secret reading failed"
        fi
    else
        printf "%s\n" "The vault did not unseal"
    fi
else
    printf "%s\n" "Vault has been initialized or file didn't write correctly"
    exit 1
fi
