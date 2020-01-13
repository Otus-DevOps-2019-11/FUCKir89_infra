#!/bin/bash
#copy daemon file
cp /home/appuser/puma.service /etc/systemd/system/puma.service
#reread systemctl daemons
systemctl daemon-reload
#enable puma daemon in autostart
systemctl enable puma.service
#start puma daemon
systemctl start puma.service
