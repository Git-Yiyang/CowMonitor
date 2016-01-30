#!/bin/sh
/bin/echo "=========="
/bin/echo "begin date:"
/bin/date
/bin/echo "move syn_temp dir to syn_ready dir"

if [ ! -d "/home/root/nfs_share/netgate/syn_ready" ];
then
	/bin/mkdir /home/root/nfs_share/netgate/syn_ready/
fi
if [ ! -d "/home/root/nfs_share/netgate/syn_temp" ];
then 
	/bin/mkdir /home/root/nfs_share/netgate/syn_temp/
fi
temp_flag=`/bin/ls "/home/root/nfs_share/netgate/syn_temp"`
if [ "$temp_flag" = "" ];
then
	/bin/echo "the syn_temp is empty!"
else
	/bin/mv /home/root/nfs_share/netgate/syn_temp/* /home/root/nfs_share/netgate/syn_ready/
fi
/bin/echo "rsync syn_ready dir to remote server"
#/bin/echo `/usr/bin/rsync -vzr --remove-sent-files /home/root/nfs_share/netgate/syn_ready/*  lab-701-laptop@192.168.8.117:/home/lab-701-laptop/cow_datas/`
temp_flag=`/bin/ls "/home/root/nfs_share/netgate/syn_ready"`
if [ "$temp_flag" = "" ];
then
	/bin/echo "the syn_ready is empty!"
else
	/usr/bin/scp  /home/root/nfs_share/netgate/syn_ready/* admin@192.168.8.117:/cygdrive/d/cow_datas/
#	/usr/bin/rsync -vzr --remove-sent-files /home/root/nfs_share/netgate/syn_ready/*  lab-701-laptop@192.168.8.117:/home/lab-701-laptop/cow_datas/

	#judge the rsync, if return 0 means success.
	#Judge_rsync(){
	if [ $? -eq 0 ];
	then
		/bin/echo "rsync success"
		/bin/echo "remove files in syn_ready"
		/bin/rm /home/root/nfs_share/netgate/syn_ready/*
	else
		/bin/echo "rsync false, return value is: ${?}"	
	fi
	#}
fi
/bin/echo "end date:"
/bin/date
/bin/echo "----------"
/bin/echo " "
/bin/echo " "
