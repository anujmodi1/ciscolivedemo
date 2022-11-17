#helm installation
sudo snap install helm --classic


#vault installation
helm repo add hashicorp https://helm.releases.hashicorp.com

kubectl create ns dev-vault
kubectl  get all -n dev-vault
helm -n dev-vault install dev-vault hashicorp/vault -f values.yaml
helm status dev-vault -n dev-vault
kubectl  get all -n dev-vault
kubectl exec -it dev-vault-0 -n dev-vault -- vault status

kubectl exec -it pod/dev-vault-0 -n dev-vault -- vault operator init -n 1 -t 1
kubectl exec -it pod/dev-vault-0 -n dev-vault -- vault operator unseal jqd2gSN5v7yc8vSTB+JkfclUBj4sQFoSfUIaSruNPqg=

export VAULT_ADDR='http://127.0.0.1:8200'

Unseal Key 1: jqd2gSN5v7yc8vSTB+JkfclUBj4sQFoSfUIaSruNPqg=

Initial Root Token: hvs.P7UxNxpespS55o3jZlI6ATGU


Initial Root Token: hvs.6dcZt80o8BSjoTmlreaa7Alz


#deleting the data in the vault
helm del --purge vault

helm uninstall dev-vault -n dev-vault