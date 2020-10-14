#!/bin/bash
## Setting up the hostname ###
dnsname="ecnode1.cloud2ark.com"
OLD_HOSTNAME="$( hostname )"
NEW_HOSTNAME="$dnsname"
hostname "$NEW_HOSTNAME"
sudo sed -i "s/HOSTNAME=.*/HOSTNAME=$NEW_HOSTNAME/g" /etc/sysconfig/network

sed -i "/$( hostname -i )/d" /etc/hosts
if [ -n "$( grep \"$OLD_HOSTNAME\" /etc/hosts )" ]; then
        sudo sed -i "s/$OLD_HOSTNAME/$NEW_HOSTNAME/g" /etc/hosts
else
        sudo echo -e "$( hostname -I | awk '{ print $1 }' )\t$NEW_HOSTNAME" >> /etc/hosts
fi

# Installing Apache 
sudo yum update -y
sudo yum install -y httpd24
sudo yum install -y mod24_ssl
sudo mkdir -p /etc/httpd/passwd
sudo htpasswd -cmb /etc/httpd/passwd/.htpasswd_es esadmin admin123
sudo sh /etc/pki/tls/certs/make-dummy-cert /etc/pki/tls/certs/localhost.crt
sudo sed -e '/SSLCertificateKeyFile/s/^/#/g' -i /etc/httpd/conf.d/ssl.conf
#Enabling proxy settings  in ssl conf file
sudo sed -i '/SSL_PROTOCOL/aProxyPass "/_cluster/health" "http://localhost:9200/"\nProxyPassReverse "/_cluster/health" "http://localhost:9200/"\n<Proxy *>\n Order deny,allow\nAllow from all\n\nAuthType Basic\nAuthName "Elastic Server"\nAuthBasicProvider file\nAuthUserFile /etc/httpd/passwd/.htpasswd_es\nRequire valid-user\n</Proxy>' /etc/httpd/conf.d/ssl.conf

sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 775 /var/www
sudo echo "<html> <h1> Health Check </h1> </html>" > /var/www/html/index.html




# Installing elasticache 
sudo rpm -i https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.3/elasticsearch-2.3.3.rpm
sudo chkconfig --add elasticsearch
sudo /usr/share/elasticsearch/bin/plugin install cloud-aws -b
sudo service elasticsearch start
sudo service httpd start
