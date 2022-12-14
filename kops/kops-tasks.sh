#!/bin/bash
#Create the AWS root and developer account, save the access key id and secret.
#https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

# create kops account user, group and assign policies to group and user.
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


aws configure --profile kops
aws s3 ls --profile kops
export AWS_PROFILE=default/kops
cat ~/.aws/credentials
aws iam list-users
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

#DNS configuration, create the hosted zone in route53
# domain name: cisco-fso-labs.com
#name servers from aws
ns-1924.awsdns-48.co.uk.
ns-1037.awsdns-01.org.
ns-193.awsdns-24.com.
ns-739.awsdns-28.net.

#test dns servers
dig ns cisco-fso-labs.com

#s3 bucket
aws s3api create-bucket \
    --bucket cisco-fso-labs-kops-state \
    --region us-west-1

#Enable versioning
aws s3api put-bucket-versioning --bucket cisco-fso-labs-kops-state  --versioning-configuration Status=Enabled
#export variables
#export NAME=cluster1.k8s.local
export NAME=k8s.cisco-fso-labs.com
export KOPS_STATE_STORE=s3://fsocloud-kops-state

#kops export kubeconfig $NAME --admin

#cluster creation
kops create cluster --name=${NAME} --cloud=aws --zones=us-west-1a --master-size t2.micro --node-size t2.micro --kubernetes-version 1.20.15
kops create cluster --name=${NAME} --cloud=aws --zones=us-west-1a --master-size t2.medium --node-size t2.medium
kops get cluster
kops edit cluster k8s.cisco-fso-labs.com
#kops update cluster --name ${NAME} --yes --admin
kops update cluster --name ${NAME} --yes --admin
kops validate cluster --wait 10m
kops delete cluster --name ${NAME} --yes
kubectl get nodes

#testing pods and loadbalancer
kubectl create deployment my-nginx --image=nginx --replicas=1 --port=80;
kubectl expose deployment my-nginx --port=80 --type=LoadBalancer;
