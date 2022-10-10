
#s3 bucket
aws s3api create-bucket bucket fsocloud-kops-state region us-east-1
#Enable versioning
aws s3api put-bucket-versioning --bucket fsocloud-kops-state  --versioning-configuration Status=Enabled
#export variables
export NAME=cluster1.k8s.local
export KOPS_STATE_STORE=s3://fsocloud-kops-state

#cluster creation
kops create cluster --name=${NAME} --cloud=aws --zones=us-east-1a --master-size t2.micro --node-size t2.micro --kubernetes-version 1.20.15
kops get cluster
kops edit cluster cluster1.k8s.local
kops update cluster --name cluster1.k8s.local --yes --admin
kops validate cluster --wait 10m
#kops delete cluster --name ${NAME} --yes
kubectl get nodes


