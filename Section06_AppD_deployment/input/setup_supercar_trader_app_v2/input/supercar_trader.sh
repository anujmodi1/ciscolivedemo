#!/bin/sh
export AWS_PAGER=""
cp config ~/.aws
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
#curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
#chmod +x ./kops
#mv ./kops /usr/local/bin/
export NAME=k8s.ciscolivedemo2022.com
export KOPS_STATE_STORE=s3://ciscolivedemo2022-kops-state
kops export config $NAME --admin
vault login --no-print $SSH_TOKEN
mkdir ~/.kube
vault kv get -field kubeconfig concourse/main/lab-kube-config > ~/.kube/config
vault kv get -field data concourse/main/appd-controller-info | base64 -d > controller-info.xml
kubectl get nodes
kubectl create ns supercar
#vault kv get -field data concourse/main/supercar-values | base64 -d > values.yaml
kubectl -n supercar delete deploy --all
helm -n supercar delete mysql
kubectl -n supercar delete pvc --all
kubectl -n supercar delete svc tomcat-lb
kubectl -n supercar delete mysql-lb
kubectl -n supercar apply -f supercar-trader.yml
kubectl -n supercar apply -f tomcat_lb.yml
kubectl -n supercar get svc
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install -n supercar mysql bitnami/mysql -f mysql-values.yaml
kubectl get nodes
kubectl get pods -w --namespace supercar
MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace supercar mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)
echo $MYSQL_ROOT_PASSWORD
apt -y update
apt -y install mysql-client
git clone https://github.com/sherifadel90/AppDynamics-SupercarsJavaApp.git
pwd
ls
cd AppDynamics-SupercarsJavaApp/Supercar-Trader/src/main/resources/db
ls
pwd
echo $MYSQL_ROOT_PASSWORD
echo "waiting for mysql loadBalancer to be provisioned in AWS....."
sleep 3m
MYSQL_LB=$(kubectl get svc --namespace supercar mysql -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
mysql -h $MYSQL_LB -uroot -p"$MYSQL_ROOT_PASSWORD" < mysql-01.sql --force
mysql -h $MYSQL_LB -uroot -p"$MYSQL_ROOT_PASSWORD" < mysql-02.sql --force
mysql -h $MYSQL_LB -uroot -p"$MYSQL_ROOT_PASSWORD" < mysql-03.sql --force



