!/bin/sh
export VAULT_ADDR="http://dev-vault.devops-ontap.com:8200"
vault login -method=aws header_value=dev-vault.devops-ontap.com role=vault
TE_GROUP=$(vault kv get -field=token concourse/cisco-fso-labs/te-group)