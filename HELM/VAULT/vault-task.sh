#helm installation
sudo snap install helm --classic


#vault installation
helm repo add hashicorp https://helm.releases.hashicorp.com

kubectl create ns dev-vault
kubectl  get all -n dev-vault
#clone the vault helm chart
git clone https://github.com:hashicorp/vault-helm.git
cd vault-helm/
#Use the chart.yaml file from repo to deploy vault
helm -n dev-vault install dev-vault . -f /Users/anmodi/dev/ciscolivedemo/HELM/VAULT/dev-vault-values.yaml
#helm -n dev-vault install dev-vault hashicorp/vault -f values.yaml
helm status dev-vault -n dev-vault
kubectl  get all -n dev-vault
kubectl exec -it dev-vault-0 -n dev-vault -- vault status
kubectl exec -it pod/dev-vault-0 -n dev-vault -- vault operator init -n 1 -t 1
kubectl exec -it pod/dev-vault-0 -n dev-vault -- vault operator unseal F/QUp6JVsbqZqbQA1Xx3DRoP4DvV2y+Wj2MBA9RSt4o=
#deleting the data in the vault
helm del --purge vault
helm uninstall dev-vault -n dev-vault

kubectl  get pods -n dev-vault
kubectl  get svc -n dev-vault
#Note down the loadbalance fqdn from the list
#Paste on browser to check if vault is accessible externally, add 8200 port no.
#After successful test, add the loadbalancer fqdn as CNAME in hosted zone in route 53 entry
http://dev-vault.cisco-fso-labs.com:8200/
#enter the root token to access the vault.

#Login into vault pod
kubectl exec -it dev-vault-0 -n dev-vault /bin/sh
vault login
#enable to concourse authentication into vault
#https://concourse-ci.org/vault-credential-manager.html

#configure kv secrets engine and mount it at /concourse
vault secrets enable -version=1 -path=concourse kv
#create a policy to allow Concourse to read from this path & save it.
path "concourse/*" {
  capabilities = ["read"]
}

#approle authentication for concourse
vault auth enable approle
#default is 1hour expiration policy
vault write auth/approle/role/concourse policies=concourse period=24h
#configure role_id and generate a secret_id to enter into concourse
vault read auth/approle/role/concourse/role-id
vault write -f auth/approle/role/concourse/secret-id

#development and main policy

path "concourse/development/*" {
  capabilities = ["read", "create","update", "list"]
}

path "concourse/main/*" {
  capabilities = ["read", "create","update", "list"]
}

#development and main secrets
aws key, secret and ssh.token
    AWS_KEY_ID: ((Access_key_ID.Access_key))
      AWS_KEY: ((Secret_access_key.Secret_access_key))
            SSH_TOKEN: ((ssh-token.token))


vault token create --policy development --period 24h