#!/bin/sh

if [ "`az account list |grep Enabled`" = "" ]; then
	echo "error: Azure account not configured, or without active subscriptions"
fi
