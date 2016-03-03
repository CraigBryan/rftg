#!/usr/bin/env bash

# Install things
sudo apt-get install -y python-dev python-setuptools
sudo easy_install pip wheel
pip install virtualenv
cd /vagrant
virtualenv rftgvenv
source rftgvenv/bin/activate
pip install -r /vagrant/requirements.txt

# clean up previous links
sudo rm /etc/nginx/sites-enabled/site.conf

# uWSGI
sudo cp /vagrant/provision/rftg_wsgi.conf /etc/init/rftg_wsgi.conf

# start wsgi process
sudo start rftg_wsgi

# nginx
sudo apt-get -y install nginx
sudo service nginx start

# set up nginx
sudo cp /vagrant/provision/nginx/nginx.conf /etc/nginx/sites-available/site.conf
sudo chmod 644 /etc/nginx/sites-available/site.conf
sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
sudo service nginx restart

# clean /var/www 
sudo rm -Rf /var/www

# symlink /var/www => /vagrant
ln -s /vagrant /var/www

