#!/bin/sh
/usr/bin/killall "netgate"
cd /home/root/nfs_share/netgate/
./netgate &
