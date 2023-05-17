#!/bin/sh
export AWS_PAGER=""
#cp config ~/.aws
cd git-resource/Section06_AppD_deployment/input/setup_supercar_trader_app_v2/input
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
#curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
#chmod +x ./kops
#mv ./kops /usr/local/bin/
export NAME=k8s.ciscolivedemo2022.com
export KOPS_STATE_STORE=s3://ciscolivedemo2022-kops-state
#kops export config $NAME --admin
vault login --no-print $SSH_TOKEN
vault --version
vault status
mkdir ~/.kube
#config file require update everyday as this will fetch new config file with kops cluster command
vault kv get -field config concourse/main/lab-kube-config > ~/.kube/config
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
#kubectl get pods -w --namespace supercar
MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace supercar mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)
echo $MYSQL_ROOT_PASSWORD
apt -y update
apt -y install mysql-client
apt -y install unzip
apt -y install net-tools
git clone https://github.com/sherifadel90/AppDynamics-SupercarsJavaApp.git
pwd
ls
#cd AppDynamics-SupercarsJavaApp/Supercar-Trader/src/main/resources/db
ls
pwd
echo $MYSQL_ROOT_PASSWORD
echo "waiting for mysql loadBalancer to be provisioned in AWS....."
sleep 3m
MYSQL_LB=$(kubectl get svc --namespace supercar mysql -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
mysql -h $MYSQL_LB -uroot -p"$MYSQL_ROOT_PASSWORD" < mysql-01.sql --force
mysql -h $MYSQL_LB -uroot -p"$MYSQL_ROOT_PASSWORD" < mysql-02.sql --force
mysql -h $MYSQL_LB -uroot -p"$MYSQL_ROOT_PASSWORD" < mysql-03.sql --force
cd /opt
mkdir appdynamics
cd /opt/appdynamics
mkdir javaagent
cd /tmp
git clone https://github.com/anujmodi1/ciscolivedemo.git
cd /tmp/ciscolivedemo/Section06_AppD_deployment/input/setup_supercar_trader_app_v2/input/
cp AppServerAgent-22.4.0.33722.zip /opt/appdynamics/javaagent/
unzip AppServerAgent-22.4.0.33722.zip
cp /tmp/ciscolivedemo/Section06_AppD_deployment/input/setup_supercar_trader_app_v2/input/controller-info.xml /opt/appdynamics/javaagent/ver22.4.0.33722/conf
sed -i '124a\ \nexport CATALINA_OPTS="$CATALINA_OPTS -javaagent:/opt/appdynamics/javaagent/javaagent.jar"\n' /opt/tomcat/bin/catalina.sh
/opt/tomcat/bin/catalina.sh run
cd /opt/appdynamics
mkdir lab-artifacts
cd /opt/appdynamics/lab-artifacts
wget https://povplaybook.appdpartnerlabs.net/zip/lab-artifacts.zip
cd /opt/appdynamics/lab-artifacts
unzip lab-artifacts.zip
chmod 754 /opt/appdynamics/lab-artifacts/phantomjs/*.sh
sed -i -e 's/\r$//' /opt/appdynamics/lab-artifacts/phantomjs/*.sh
cd /opt/appdynamics/lab-artifacts/phantomjs
./start_load.sh



