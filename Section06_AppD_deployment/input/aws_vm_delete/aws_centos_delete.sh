#!/bin/sh
export AWS_PAGER=""
#This is required for vault
setcap cap_ipc_lock= /usr/bin/vault
export NAME=$NAME
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $VAULT_TOKEN
#Get vpcid from vault
vpcid=$(vault kv get --field=vpcid concourse/main/$NAME/vpcid)
export vpcid=$vpcid
echo $vpcid
#Get centos instance id from vault
centos_instance_id=$(vault kv get --field=centos_instance_id concourse/main/$NAME/centos_instance_id)
export centos_instance_id=$centos_instance_id
echo $centos_instance_id
#Delete Instance and Poll State until Terminated
aws ec2 terminate-instances --instance-ids $centos_instance_id
aws ec2 wait instance-terminated --instance-ids $centos_instance_id
