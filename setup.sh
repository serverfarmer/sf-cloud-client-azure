#!/bin/sh

/opt/farm/ext/cloud-client-azure/setup-azcli.sh

/opt/farm/scripts/setup/extension.sh sf-php

echo "setting up base directory"
mkdir -p /etc/local/.cloud/azure
