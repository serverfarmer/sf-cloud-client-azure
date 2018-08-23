#!/bin/sh

ls /etc/local/.ssh/id_azure_* |grep -v \.pub$ |grep -v \.meta$ |sed s/\\\/etc\\\/local\\\/.ssh\\\/id_azure_//g
