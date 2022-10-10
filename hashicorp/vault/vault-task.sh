#helm installation
sudo snap install helm --classic


#vault installation
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault

kubectl  get all
kubectl exec -it pod/vault-0 -- vault status
kubectl exec -it pod/vault-0 -- vault operator init -n 1 -t 1
kubectl exec -it pod/vault-0 -- vault operator unseal jMxnHnqd0LVT/TTWOFOT8ABkbqiyr94pJBFYpx+d8GA=

export VAULT_ADDR='http://127.0.0.1:8200'

export $VAULT_ROOT_KEY=hvs.vjFLuz59y4omowLjWDcS0gXu

Unseal Key 1: jMxnHnqd0LVT/TTWOFOT8ABkbqiyr94pJBFYpx+d8GA=
Initial Root Token: hvs.vjFLuz59y4omowLjWDcS0gXu

#deleting the data in the vault
helm del --purge vault

