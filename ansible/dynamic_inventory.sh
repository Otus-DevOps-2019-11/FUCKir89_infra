#!/bin/bash
cd ../terraform/stage && terraform output dynamic_inventory > ../../ansible/inventory.json
