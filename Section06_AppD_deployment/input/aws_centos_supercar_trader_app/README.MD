#Installing the AppD CentOS7 VM + SuperCar Trader App + AppD Agent


[ec2-user@ip-172-31-15-240 tmp]$ sudo grep 'temporary password' /var/log/mysqld.log
2023-05-18T09:32:31.156955Z 1 [Note] A temporary password is generated for root@localhost: yB8mus5ao-Ad

[centos@ip-172-31-2-92 tmp]$ sudo grep 'temporary password' /var/log/mysqld.log
2023-05-18T10:37:51.390606Z 1 [Note] A temporary password is generated for root@localhost: ggshBiu;a2jq


[ec2-user@ip-172-31-8-98 tmp]$ phantomjs --version
Auto configuration failed
140219269998400:error:25066067:DSO support routines:DLFCN_LOAD:could not load the shared library:dso_dlfcn.c:185:filename(libproviders.so): libproviders.so: cannot open shared object file: No such file or directory
140219269998400:error:25070067:DSO support routines:DSO_load:could not load the shared library:dso_lib.c:244:
140219269998400:error:0E07506E:configuration file routines:MODULE_LOAD_DSO:error loading dso:conf_mod.c:285:module=providers, path=providers
140219269998400:error:0E076071:configuration file routines:MODULE_RUN:unknown module name:conf_mod.c:222:module=providers
[ec2-user@ip-172-31-8-98 tmp]$ sudo ln -s /opt/appdynamics/platform/product/controller/reporting_service/reports/node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs /usr/local/bin/
ln: failed to create symbolic link '/usr/local/bin/phantomjs': File exists

Solution: 
export OPENSSL_CONF=/etc/ssl
OPENSSL_CONF=/etc/ssl phantomjs --version

https://github.com/ariya/phantomjs/issues/15449


Application Server Setup commands
ls
2  cd /opt
3  sudo mkdir appdynamics
4  sudo chown -R ec2-user:ec2-user /opt/appdynamics
5  cd /opt/appdynamics
6  mkdir lab-artifacts
7  sudo -y yum install wget
8  cd /opt/appdynamics/lab-artifacts
9  wget https://povplaybook.appdpartnerlabs.net/zip/lab-artifacts.zip
10  cd /opt/appdynamics/lab-artifacts
11  unzip lab-artifacts.zip
12  sudo -y yum install java-1.8.0
13  java -version
14  wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
15  sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
16  sudo yum install mysql-server
17  cd /tmp
18  vi mysql_pubkey.asc
19  gpg --import mysql_pubkey.asc
20  sudo rpm --import mysql_pubkey.asc
21  sudo yum install mysql-server
22  sudo systemctl start mysqld
23  service mysqld status
24  sudo grep 'temporary password' /var/log/mysqld.log
25  mysql_secure_installation
26  cd /opt/appdynamics/lab-artifacts/db-scripts
27  mysql -u root -pWelcome1! < mysql-01.sql
28  mysql -u root -pWelcome1! < mysql-02.sql
29  mysql -u root -pWelcome1! < mysql-03.sql
30  cd /usr/local
31  sudo mkdir apache
32  cd /usr/local/apache
33  sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz
34  sudo tar -zxpvf apache-tomcat-9.0.50.tar.gz -C /usr/local/apache
35  sudo chown -R ec2-user:ec2-user /usr/local/apache
36  mv apache-tomcat-9.0.50 apache-tomcat-9
37  echo "export CATALINA_HOME='/usr/local/apache/apache-tomcat-9/'" >> ~/.bashrc
38  source ~/.bashrc
39  vi /usr/local/apache/apache-tomcat-9/conf/tomcat-users.xml
40  vi /usr/local/apache/apache-tomcat-9/webapps/manager/META-INF/context.xml
41  vi /usr/local/apache/apache-tomcat-9/conf/tomcat-users.xml
42  cd /usr/local/apache/apache-tomcat-9/bin
43  ./startup.sh
44  sudo netstat -tulpn | grep LISTEN
45  cd /tmp
46  sudo yum install glibc fontconfig freetype freetype-devel fontconfig-devel wget bzip2
47  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
48  sudo tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/
49  sudo ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
50  phantomjs --version
51  export OPENSSL_CONF=/etc/ssl
52  phantomjs --version
53  history
54  cd /usr/local/apache/apache-tomcat-9/bin
55  ./shutdown.sh
57  cd /usr/local/apache/apache-tomcat-9/bin
58  ./startup.sh
59  sudo netstat -tulpn | grep LISTEN
60  vi /usr/local/apache/apache-tomcat-9/conf/tomcat-users.xml
61  cd /opt/appdynamics
62  mkdir javaagent
63  cd /tmp
64  git clone https://github.com/anujmodi1/ciscolivedemo.git
65  yum -y install git
66  sudo yum -y install git
67  git clone https://github.com/anujmodi1/ciscolivedemo.git
68  cd ciscolivedemo/Section06_AppD_deployment/input/setup_supercar_trader_app_v2/input/
69  ls
70  cp AppServerAgent-22.4.0.33722.zip /opt/appdynamics/javaagent/
71  cd /opt/appdynamics/javaagent/
72  ls
73  unzip AppServerAgent-22.4.0.33722.zip
74  ls
75  cd conf
76  ls
77  vi controller-info.xml
78  cd /usr/local/apache/apache-tomcat-9/bin
79  ./shutdown.sh
80  vi catalina.sh
81  ./startup.sh
82  sudo netstat -tulpn | grep LISTEN
83  cat /opt/appdynamics/javaagent/ver22.4.0.33722/conf/controller-info.xml
84  vi /opt/appdynamics/javaagent/ver22.4.0.33722/conf/controller-info.xml
85  sudo chmod 754 /opt/appdynamics/lab-artifacts/phantomjs/*.sh
86  sed -i -e 's/\r$//' /opt/appdynamics/lab-artifacts/phantomjs/*.sh
87  cd /opt/appdynamics/lab-artifacts/phantomjs
88  ./start_load.sh
89  cd /usr/local/apache/apache-tomcat-9/bin
90  ./shutdown.sh
91  ./startup.sh
92  cat /opt/appdynamics/javaagent/ver22.4.0.33722/conf/controller-info.xml
93  cd /opt/appdynamics/lab-artifacts/phantomjs
94  ./start_load.sh
95  df -h
96  history

#CentOS Deployment
cd /opt
sudo mkdir appdynamics
sudo chown -R centos:centos /opt/appdynamics
cd /opt/appdynamics
mkdir lab-artifacts
sudo yum -y install wget
cd /opt/appdynamics/lab-artifacts
wget https://povplaybook.appdpartnerlabs.net/zip/lab-artifacts.zip
cd /opt/appdynamics/lab-artifacts
sudo yum -y install unzip
unzip lab-artifacts.zip
sudo yum -y install java-1.8.0
java -version
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
sudo yum -y install mysql-server
cd /tmp
vi mysql_pubkey.asc
gpg --import mysql_pubkey.asc
sudo rpm --import mysql_pubkey.asc
sudo yum -y install mysql-server
sudo systemctl start mysqld
service mysqld status
sudo grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation
cd /opt/appdynamics/lab-artifacts/db-scripts
mysql -u root -pWelcome1! < mysql-01.sql
mysql -u root -pWelcome1! < mysql-02.sql
mysql -u root -pWelcome1! < mysql-03.sql
cd /usr/local
sudo mkdir apache
cd /usr/local/apache
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz
sudo tar -zxpvf apache-tomcat-9.0.50.tar.gz -C /usr/local/apache
sudo chown -R centos:centos /usr/local/apache
mv apache-tomcat-9.0.50 apache-tomcat-9
echo "export CATALINA_HOME='/usr/local/apache/apache-tomcat-9/'" >> ~/.bashrc
source ~/.bashrc
vi /usr/local/apache/apache-tomcat-9/conf/tomcat-users.xml
vi /usr/local/apache/apache-tomcat-9/webapps/manager/META-INF/context.xml
cd /usr/local/apache/apache-tomcat-9/bin
./startup.sh
sudo netstat -tulpn | grep LISTEN
cd /tmp
sudo yum -y install glibc fontconfig freetype freetype-devel fontconfig-devel wget bzip2
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
sudo tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/
sudo ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
phantomjs --version
# only for aws linux
#export OPENSSL_CONF=/etc/ssl
phantomjs --version

cd /usr/local/apache/apache-tomcat-9/bin
./shutdown.sh
cd /usr/local/apache/apache-tomcat-9/bin
./startup.sh
sudo netstat -tulpn | grep LISTEN
vi /usr/local/apache/apache-tomcat-9/conf/tomcat-users.xml
cd /opt/appdynamics
mkdir javaagent
cd /tmp
git clone https://github.com/anujmodi1/ciscolivedemo.git
sudo yum -y install git
git clone https://github.com/anujmodi1/ciscolivedemo.git
cd ciscolivedemo/Section06_AppD_deployment/input/setup_supercar_trader_app_v2/input/
ls
cp AppServerAgent-22.4.0.33722.zip /opt/appdynamics/javaagent/
cd /opt/appdynamics/javaagent/
unzip AppServerAgent-22.4.0.33722.zip
cd conf
vi controller-info.xml
cd /usr/local/apache/apache-tomcat-9/bin
./shutdown.sh
vi catalina.sh
./startup.sh
sudo netstat -tulpn | grep LISTEN
cat /opt/appdynamics/javaagent/ver22.4.0.33722/conf/controller-info.xml
vi /opt/appdynamics/javaagent/ver22.4.0.33722/conf/controller-info.xml
sudo chmod 754 /opt/appdynamics/lab-artifacts/phantomjs/*.sh
sed -i -e 's/\r$//' /opt/appdynamics/lab-artifacts/phantomjs/*.sh
cd /opt/appdynamics/lab-artifacts/phantomjs
./start_load.sh
cd /usr/local/apache/apache-tomcat-9/bin
./shutdown.sh
./startup.sh
cat /opt/appdynamics/javaagent/ver22.4.0.33722/conf/controller-info.xml 
cd /opt/appdynamics/lab-artifacts/phantomjs
./start_load.sh
df -h
history
