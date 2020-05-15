#!/bin/bash
sudo apt-get install -y gcc unzip libgeoip-dev python-virtualenv python-dev geoip-database-extra uwsgi uwsgi-plugin-python nginx git
cd /srv
git clone https://github.com/predators46/monitoring.git
wget https://github.com/furlongm/openvpn-monitor/archive/1.0.0.zip
unzip 1.0.0.zip
mv openvpn-monitor-1.0.0 openvpn-monitor
cd openvpn-monitor
virtualenv .
. bin/activate
pip install -r requirements.txt
cp openvpn-monitor.conf.example openvpn-monitor.conf
sed -i "s@host=localhost@host=$IP@g" openvpn-monitor.conf
sed -i 's@port=5555@port=5555@g' openvpn-monitor.conf
cp /srv/monitoring/openvpn-monitor.ini /etc/uwsgi/apps-available/
ln -s /etc/uwsgi/apps-available/openvpn-monitor.ini /etc/uwsgi/apps-enabled/
cp /srv/monitoring/monitoring.conf /etc/nginx/conf.d/
cp /srv/monitoring/nginx.conf /etc/nginx/
mkdir /var/lib/GeoIP
cp /srv/monitoring/GeoLite2-City.mmdb /var/lib/GeoIP
service uwsgi restart
service nginx restart

