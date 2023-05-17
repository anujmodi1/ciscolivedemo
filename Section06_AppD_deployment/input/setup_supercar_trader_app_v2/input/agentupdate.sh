#!/bin/bash

yum -y install unzip net-tools wget
cd /opt
mkdir appdynamics
cd /opt/appdynamics
mkdir javaagent
cd /tmp
git clone https://github.com/anujmodi1/ciscolivedemo.git
cd /tmp/ciscolivedemo/Section06_AppD_deployment/input/setup_supercar_trader_app_v2/input/
cp AppServerAgent-22.4.0.33722.zip /opt/appdynamics/javaagent/
cd /opt/appdynamics/javaagent/
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
