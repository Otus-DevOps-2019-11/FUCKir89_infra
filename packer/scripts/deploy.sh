#!/bin/bash
#clone the repo
git clone -b monolith https://github.com/express42/reddit.git /home/appuser/soft/
#install bundle
cd /home/appuser/soft/ && bundle install
#start the app
puma -d
