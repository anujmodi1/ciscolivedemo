#!/bin/sh
export AWS_PAGER=""
#This is required for vault
setcap cap_ipc_lock= /usr/bin/vault
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $VAULT_TOKEN
#Writing the AZ and Region to the vault
#This script imports the lab_vars.py file and writes the vars to the vault under the az name mount
vault kv get concourse/test
vault kv get concourse/ssh-token
vault kv get concourse/main/ssh-token
#vault kv list concourse/main/
#Writing the az and region to the vault
#this scripts imports the lab.vars.py
echo "successfully authentication"
#echo $VAULT_TOKEN
#cd git-resource/tasks/aws_deploy
#python3 vault_prep.py







