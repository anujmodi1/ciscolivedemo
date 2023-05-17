#!/bin/sh
export AWS_PAGER=""
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $VAULT_TOKEN
export NAME=$NAME
python3 git-resource/Section06_AppD_deployment/input/aws_centos_supercar_trader_app/aws-deploy-env-train.py
