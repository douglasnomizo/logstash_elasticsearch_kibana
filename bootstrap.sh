#!/bin/bash

echo 'Using root to install packages'
sudo su -

echo 'Updating aptitude'
aptitude update

if which java >/dev/null 2>&1 ; then
  echo 'Java already installed'
else
  echo 'Installing Headless Java'
  aptitude install openjdk-7-jre-headless -y
fi

if which /etc/init.d/elasticsearch >/dev/null 2>&1 ; then
  echo 'Elastic Search already installed'
else
  echo 'Installing Elastic Search'
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb
  dpkg -i elasticsearch-0.90.5.deb
fi

if [ -f "/opt/logstash/logstash.jar" ] ;
then
  echo 'Logstash already downloaded. Find it on /opt/logstash/'
else
  echo 'Downloading logstash'
  mkdir /opt/logstash
  cd /opt/logstash
  wget https://download.elasticsearch.org/logstash/logstash/logstash-1.2.2-flatjar.jar
  mv logstash-1.2.2-flatjar.jar logstash.jar
fi

echo 'Improve things above this line'

echo 'Installing Ngix'
apt-get install nginx -y

echo 'Installing unzip'
apt-get install unzip -y

echo 'Downloading kibana'
cd /opt
wget http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip
unzip kibana-lastest.zip
mv kibana-lastest kibana
