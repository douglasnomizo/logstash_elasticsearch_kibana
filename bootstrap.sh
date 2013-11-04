#!/bin/bash

echo '***** Logging as root'
sudo su -

echo '***** Updating aptitude and apt-get. Wait please...'
aptitude update
apt-get update

if java -version >/dev/null 2>&1 ; then
  echo '***** Java already installed'
else
  echo '***** Installing Headless Java'
  aptitude install openjdk-7-jre-headless -y
fi

if /etc/init.d/elasticsearch status >/dev/null 2>&1 ; then
  echo '***** Elastic Search already installed'
else
  echo '***** Installing Elastic Search'
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb --quiet
  dpkg -i elasticsearch-0.90.5.deb
fi

if [ -f "/opt/logstash/logstash.jar" ] ; then
  echo '***** Logstash already downloaded. Find it on /opt/logstash/'
else
  echo '***** Downloading logstash'
  mkdir /opt/logstash
  cd /opt/logstash
  wget https://download.elasticsearch.org/logstash/logstash/logstash-1.2.2-flatjar.jar --quiet
  mv logstash-1.2.2-flatjar.jar logstash.jar
fi

if nginx -v >/dev/null 2>&1 ; then
  echo '***** Nginx already installed'
else
  echo '***** Installing Ngix'
  apt-get install nginx -y
fi

if unzip -v >/dev/null 2>&1 ; then
  echo '***** Unzip already installed'
else
  echo '*****Installing unzip'
  apt-get install unzip -y
fi

if [ -f "/opt/kibana-latest.zip" ] ; then
  echo '***** Kibana already downloaded'
else
  echo '***** Downloading kibana'
  cd /opt
  wget http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip --quiet
fi

if [ -d '/usr/share/nginx/kibana' ] ; then
  echo '***** Kibana already in nginx directory'
else
  echo '***** Extracting and moving Kibana to nginx directory'
  cd /opt
  unzip kibana-latest.zip
  mv kibana-latest /usr/share/nginx/kibana
  sed -i "s/www/kibana/g" /etc/nginx/sites-available/default
  service nginx restart
fi
