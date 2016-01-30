#!/bin/sh
#/usr/bin/script -a /home/root/netgate_system.log
/sbin/ifconfig eth0 192.168.8.11 netmask 255.255.255.0
/sbin/route add default gw 192.168.8.2
/sbin/hwclock --hctosys
/usr/sbin/crond start
sleep 3
#/bin/mount 192.168.8.171:/root/nfs_share/thomas /tmp -o nolock
/sbin/insmod /home/root/nfs_share/module/my_CC2500.ko
/bin/mknod /dev/my_cc2500 c 251 0
sleep 5
/bin/sh /home/root/netgate_start.sh >> /home/root/netgate_run.log 2>& 1
