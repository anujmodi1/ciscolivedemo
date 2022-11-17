aws configure --profile cisco-gprs-arch
export AWS_PROFILE=cisco-gprs-arch
aws s3 ls
aws iam create-group --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonSQSFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess --group-name kops

aws iam create-user --user-name kops
aws iam add-user-to-group --user-name kops --group-name kops
aws iam create-access-key --user-name kops

aws configure --profile gprs-kops
export AWS_PROFILE=gprs-kops
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

dig ns ciscolivedemo2022.com
ns-1731.awsdns-24.co.uk.
ns-1324.awsdns-37.org.
ns-331.awsdns-41.com.
ns-631.awsdns-14.net.

aws s3api create-bucket \
    --bucket $KOPS_STATE_STORE \
    --region ap-south-1 \
    --create-bucket-configuration LocationConstraint=ap-south-1

aws s3api put-bucket-versioning --bucket $KOPS_STATE_STORE  --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=http://ciscolivedemo2022-kops-state.s3.amazonaws.com

export NAME=k8s.ciscolivedemo2022.com
export KOPS_STATE_STORE=s3://ciscolivedemo2022-kops-state
#kops export kubeconfig $NAME --admin
#cluster creation
kops create cluster --name=${NAME} --cloud=aws --zones=ap-south-1a --master-size t2.medium --node-size t2.medium
kops create cluster --name=${NAME} --cloud=aws --zones=ap-south-1a --master-size t2.micro --node-size t2.micro --kubernetes-version 1.20.15
kops update cluster --name ${NAME} --yes --admin
kops validate cluster --wait 10m
#kops delete cluster --name ${NAME} --yes
kubectl get nodes

