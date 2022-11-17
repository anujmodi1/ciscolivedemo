#!/bin/sh
export AWS_PAGER=""
export name=$NAME
ip='54.177.5.8'
export ip=$ip
export VAULT_ADDR=$VAULT_ADDR
export SSH_TOKEN=$SSH_TOKEN
export TE_GROUP=$TE_GROUP
vault login --no-print $SSH_TOKEN
vault kv get --field=ssh-key concourse/cisco-fso-labs/$NAME/ssh-key >> sshkey.pem
echo $TE_GROUP
chmod 400 sshkey.pem
python3 install_te_agent.py