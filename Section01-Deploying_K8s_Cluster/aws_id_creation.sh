
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

#Configure kops id
aws configure --profile kops

#**Creating s3 bucket**
aws s3api create-bucket \
--bucket ciscolivedemo2022-kops-state \
--region ap-south-1 \
--create-bucket-configuration LocationConstraint=ap-south-1

#Enable versioning
aws s3api put-bucket-versioning --bucket ciscolivedemo-kops-state  --versioning-configuration Status=Enabled
#export variables
#export NAME=cluster1.k8s.local
export NAME=k8s.ciscolivedemo2022.com
export KOPS_STATE_STORE=s3://ciscolivedemo2022-kops-state

