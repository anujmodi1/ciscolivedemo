
#concourse installation
#clone the concourse helm chart
git clone https://github.com/concourse/concourse-chart.git
cd concourse-chart/
#add the concourse helm repo
helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo add bitnami https://charts.bitnami.com/bitnami
cd concourse-chart/
helm dependency build
kubectl create ns dev-ci
helm -n dev-ci install dev-ci . -f /Users/anmodi/dev/ciscolivedemo/HELM/CONCOURSE/dev/dev-ci-values.yaml
kubectl get svc -n dev-ci
kubectl get pods -n dev-ci
helm uninstall dev-ci -n dev-ci

Note down the loadbalance fqdn from the list
#Paste on browser to check if concourse is accessible externally, add 8080 port no.
#After successful test, add the loadbalancer fqdn as CNAME in hosted zone in route 53 entry
http://dev-ci.cisco-fso-labs.com:8080/
#enter the default user name & password as values.yaml file
cd /Users/anmodi/dev/cisco-fso-labs/HELM/CONCOURSE
fly --target=cisco-fso-labs login --concourse-url=http://dev-ci.cisco-fso-labs.com:8080 -n main --username=ci --password=PASSWORD!
fly --target=development login --concourse-url=http://dev-ci.ciscolivedemo2022.com:8080 -n main --username=ci --password=cisco@2022

# create team cisco-fso--labs
#setting up team and users
#https://concourse-ci.org/managing-teams.html
fly -t cisco-fso-labs set-team --team-name cisco-fso-labs --local-user us-west-2a
fly -t cisco-fso-labs set-team -n cisco-fso-labs -c operator-role-cisco-fso-labs.yml

