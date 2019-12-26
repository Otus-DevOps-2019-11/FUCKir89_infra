#!/bin/bash
packer build -var-file=../packer/variables_immutable.json ../packer/immutable.json

gcloud compute instances create reddit-app \
--machine-type=g1-small \
--image=reddit-base-img \
--image-project=infra-262408 \
--reservation-affinity=any \
--tags puma-server \
--restart-on-failure

gcloud compute  firewall-rules create default-puma-server \
--direction=INGRESS \
--priority=1000 \
--network=default \
--action=ALLOW \
--rules=tcp:9292 \
--source-ranges=0.0.0.0/0 \
--target-tags=puma-server \
--project=infra-262408
