#!/bin/sh
export AWS_PAGER=""
rm -rf __pycache__
#login to vault - pipeline passes in these vars to build container - an alternative is make api call from python
export NAME=$NAME
export AWS_PAGER=""
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $VAULT_TOKEN
#Get values for env vars
export vpcid=$(vault kv get --field=vpcid concourse/cisco-fso-labs/$NAME/vpcid)
export sgid=$(vault kv get --field=sgid concourse/cisco-fso-labs/$NAME/sgid)
export subnetid_router=$(vault kv get --field=subnetid_router concourse/main/$NAME/subnetid_router)
export subnetid_lan=$(vault kv get --field=subnetid_lan concourse/main/$NAME/subnetid_lan)
cd git-resource/tasks/super-car-trader/input
python3 super-car-trader.py

