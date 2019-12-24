#!/bin/bash
#add repo key
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
#add repo list
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
#update repo list
sudo apt update
#install mongo
sudo apt-get install -y mongodb-org
#start mongo
sudo systemctl start mongod
#enable autostart mongo
sudo systemctl enable mongod
