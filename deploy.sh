#!/bin/bash
#clone the repo
git clone -b monolith https://github.com/express42/reddit.git /home/appuser/
#install bundle
cd /home/appuser/reddit && bundle install
