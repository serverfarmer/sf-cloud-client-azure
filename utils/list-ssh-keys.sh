#!/bin/sh

ls /etc/local/.ssh/id_azure_* 2>/dev/null |grep -v \.pub$ |grep -v \.meta$ |sed s/\\\/etc\\\/local\\\/.ssh\\\/id_azure_//g
