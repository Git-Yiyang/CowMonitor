#!/bin/sh
/bin/echo "========begin time:"
/bin/date
/bin/echo "start backup data and log files:"
Cur_date=`date "+%Y%m%d"`
Cur_date=`expr ${Cur_date} - 1`

#/bin/cat /home/root/netgate_script.log >> /home/root/backup/netgate_script.log.backup
#/bin/cat /home/root/netgate_run.log >> /home/root/backup/netgate_run.log.backup

if [ ! -d "/home/root/nfs_share/netgate/DataFile/"${Cur_date}"/" ];
then
	mkdir "/home/root/nfs_share/netgate/DataFile/"${Cur_date}"/"
fi
/bin/mv "/home/root/netgate_script.log" "/home/root/nfs_share/netgate/DataFile/"${Cur_date}"/netgate_script_"${Cur_date}".log"
/bin/mv "/home/root/netgate_run.log" "/home/root/nfs_share/netgate/DataFile/"${Cur_date}"/netgate_run_"${Cur_date}".log"

if [ ! -d "/home/root/backup/" ];
	then
	mkdir "/home/root/backup/"
fi
cd "/home/root/nfs_share/netgate/DataFile/"
/bin/tar -jcvf  "/home/root/backup/DataFile_"${Cur_date}".tar.bz2" ${Cur_date}

if [ $? -eq 0 ];
then
	#remove the files
	/bin/rm "/home/root/nfs_share/netgate/DataFile/"${Cur_date}"/*"
	echo "the date:"$Cur_date"'s files backup local successful!"
	#move the backup files to sd card
	if [ -b "/dev/mmcblk1p2" ];
	then
		echo "/dev/mmcblk1p2 exist, means SD card exist!"
		if [ -d "/media/mmcblk1p2/backup" ];
		then
			echo "/media/mmcblk1p2/backup exist"
			/bin/mv /home/root/backup/*.tar.bz2  /media/mmcblk1p2/backup/
			#/bin/cp /home/root/backup/*log.backup /media/mmcblk1p2/backup/
		else
			echo "/media/mmcblk1p2/backup not exist! mount it"
			/bin/mount /dev/mmcblk1p2 /media/mmcblk1p2
			if [ $? -eq 0 ];
			then
				echo "mount SD card successful"
				if [ -d "/media/mmcblk1p2/backup" ];
				then 	
					echo "/media/mmcblk1p2/backup exist now"
					/bin/mv /home/root/backup/*.tar.bz2  /media/mmcblk1p2/backup/
					#/bin/cp /home/root/backup/*log.backup /media/mmcblk1p2/backup/
				else
					echo "/media/mmcblk1p2/backup not exist too! create it"	
					/bin/mkdir /media/mmcblk1p2/backup
					if [ $? -eq 0 ];
					then
						echo "create backup directory successful"
						/bin/mv /home/root/backup/*.tar.bz2  /media/mmcblk1p2/backup/
						#/bin/cp /home/root/backup/*log.backup /media/mmcblk1p2/backup/
					else	
						echo "create backup directory false!, return value is $?"
					fi
				fi
			else
				echo "mount SD card(/dev/mmcblk1p2) false!, return value is $?"
			fi
		fi
	else
		echo "SD card(/dev/mmcblk1p2) not exist,please insert the SD card"
	fi
else
	echo "the date:"$Cur_date"'s file backup false!"
fi

/bin/echo "--------end time:"
/bin/date
/bin/echo ""
/bin/echo ""
