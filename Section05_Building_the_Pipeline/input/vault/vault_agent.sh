#!/bin/sh
export AWS_PAGER=""
#This is required for vault
setcap cap_ipc_lock= /usr/bin/vault
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $VAULT_TOKEN
vault kv list concourse/main/
#Writing the az and region to the vault
#this scripts imports the lab.vars.py
echo "successfully authentication"
#echo $VAULT_TOKEN
python3 ./vault/vault_agent.py