export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
export NAME=k8s.ciscolivedemo2022.com
export KOPS_STATE_STORE=s3://ciscolivedemo2022-kops-state
kops export kubeconfig $NAME --admin
kops create cluster --name=${NAME} --cloud=aws --zones=ap-south-1a --master-size t2.medium --node-size t2.medium
kops get cluster
kops update cluster --name ${NAME} --yes --admin
kops validate cluster --wait 10m