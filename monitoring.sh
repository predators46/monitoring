#!/bin/bash
function monitoring () {
apt-get install -y gcc libgeoip-dev python-virtualenv python-dev geoip-database-extra uwsgi uwsgi-plugin-python geoipupdate
cd /srv
git clone https://github.com/furlongm/openvpn-monitor.git
cd openvpn-monitor
virtualenv .
. bin/activate
pip install -r requirements.txt
cp openvpn-monitor.conf.example openvpn-monitor.conf
sed -i "s@host=localhost@host=$IP@g" openvpn-monitor.conf
sed -i 's@port=5555@port=7505@g' openvpn-monitor.conf
cd ~/openvpndeb/
cp openvpn-monitor.ini /etc/uwsgi/apps-available/
ln -s /etc/uwsgi/apps-available/openvpn-monitor.ini /etc/uwsgi/apps-enabled/
cp ~/openvpndeb/ocs.conf /etc/nginx/conf.d/
cp ~/openvpndeb/monitoring.conf /etc/nginx/conf.d/
cp /etc/nginx/
}
