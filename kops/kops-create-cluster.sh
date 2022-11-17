export NAME=k8s.cisco-fso-labs.com
export KOPS_STATE_STORE=s3://fsocloud-kops-state
#kops export kubeconfig $NAME --admin
#cluster creation
kops create cluster --name=${NAME} --cloud=aws --zones=us-west-1a --master-size t2.medium --node-size t2.medium
kops update cluster --name ${NAME} --yes --admin
kops validate cluster --wait 10m
#kops delete cluster --name ${NAME} --yes
kubectl get nodes

