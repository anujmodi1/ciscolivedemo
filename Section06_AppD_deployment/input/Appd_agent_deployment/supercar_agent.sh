#!/bin/sh
export AWS_PAGER=""
cd git-resource/Section06_AppD_deployment/input/Appd_agent_deployment
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $SSH_TOKEN
vault --version
export NAME=k8s.ciscolivedemo2022.com
export KOPS_STATE_STORE=s3://ciscolivedemo2022-kops-state
mkdir ~/.kube
vault kv get -field config concourse/main/lab-kube-config > ~/.kube/config
vault kv get -field data concourse/main/appd-controller-info | base64 -d > controller-info.xml
kubectl get nodes
tomcat_sc=$(kubectl get pods --namespace supercar --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep tomcat)
kubectl exec -it $tomcat_sc -n supercar /bin/sh
yum update
yum install unzip

curl -L -O -H "Authorization: Bearer eyJraWQiOiI0MTMxOTUyYi02Y2E4LTQ1ZTItYWJiZC01NzIwZjFmZDZiOGMiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBcHBEeW5hbWljcyIsImF1ZCI6IkFwcERfQVBJcyIsImp0aSI6IlhzMmNBRGVqQ0RQQXBsUUVKQ0tuR0EiLCJzdWIiOiJjaXNjb2xpdmVkZW1vIiwiaWRUeXBlIjoiQVBJX0NMSUVOVCIsImlkIjoiZWVjN2M3ZDctNTJmZS00NzM4LWIyYWQtMzIyMmUzM2I4ZDlmIiwiYWNjdElkIjoiNDEzMTk1MmItNmNhOC00NWUyLWFiYmQtNTcyMGYxZmQ2YjhjIiwidG50SWQiOiI0MTMxOTUyYi02Y2E4LTQ1ZTItYWJiZC01NzIwZjFmZDZiOGMiLCJhY2N0TmFtZSI6ImNpc2NvLWFwaXBhcnRuZXJ0cmFpbmluZ2xhYiIsInRlbmFudE5hbWUiOiIiLCJmbW1UbnRJZCI6bnVsbCwiYWNjdFBlcm0iOltdLCJyb2xlSWRzIjpbXSwiaWF0IjoxNjg0MTM0NDU5LCJuYmYiOjE2ODQxMzQzMzksImV4cCI6MTY4NDIyMDg1OSwidG9rZW5UeXBlIjoiQUNDRVNTIn0.30MgVuNZFdethGyr-znd3npIvuohv3QQC31Uy8jFlys;" "https://download.appdynamics.com/download/prox/download-file/sun-jvm/22.4.0.33722/AppServerAgent-22.4.0.33722"

https://download.appdynamics.com/download/prox/download-file/java-jdk8/23.4.0.34758/AppServerAgent-1.8-23.4.0.34758.zip
Click

curl -L -O -H "Authorization: Bearer eyJraWQiOiI0MTMxOTUyYi02Y2E4LTQ1ZTItYWJiZC01NzIwZjFmZDZiOGMiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBcHBEeW5hbWljcyIsImF1ZCI6IkFwcERfQVBJcyIsImp0aSI6IlhzMmNBRGVqQ0RQQXBsUUVKQ0tuR0EiLCJzdWIiOiJjaXNjb2xpdmVkZW1vIiwiaWRUeXBlIjoiQVBJX0NMSUVOVCIsImlkIjoiZWVjN2M3ZDctNTJmZS00NzM4LWIyYWQtMzIyMmUzM2I4ZDlmIiwiYWNjdElkIjoiNDEzMTk1MmItNmNhOC00NWUyLWFiYmQtNTcyMGYxZmQ2YjhjIiwidG50SWQiOiI0MTMxOTUyYi02Y2E4LTQ1ZTItYWJiZC01NzIwZjFmZDZiOGMiLCJhY2N0TmFtZSI6ImNpc2NvLWFwaXBhcnRuZXJ0cmFpbmluZ2xhYiIsInRlbmFudE5hbWUiOiIiLCJmbW1UbnRJZCI6bnVsbCwiYWNjdFBlcm0iOltdLCJyb2xlSWRzIjpbXSwiaWF0IjoxNjg0MTM0NDU5LCJuYmYiOjE2ODQxMzQzMzksImV4cCI6MTY4NDIyMDg1OSwidG9rZW5UeXBlIjoiQUNDRVNTIn0.30MgVuNZFdethGyr-znd3npIvuohv3QQC31Uy8jFlys;" "https://download.appdynamics.com/download/prox/download-file/sun-jvm/java-jdk8/22.4.0.33722/AppServerAgent-1.8-22.4.0.33722.zip"

java-jdk8/22.4.0.33722/AppServerAgent-1.8-22.4.0.33722.zip

Here