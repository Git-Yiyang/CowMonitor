# CowMonitor
A system for monitor cow daily activity.Using wireless sensor network and embedded system.

node: netgate code is build by gnu-arm-g++ and it can open in codeblocks. 

CowMonitor System mainly contain 3 parts:
1,wireless sensor node, its path :xnode
	contain: accelerometer sensor, 2.4GHz wireless RF transceiver, 123KHz wireless RF recevier, msp430 microcontroller.
2,forward gateway, its path :gateway
	contain: wireless RF transceiver's driver, spi bus driver, Multi-thread listenning service for communication between the xnode and the gateway,script for data synchronization between the gateway and the server.
3,analysis server, its path :server
	contain:script for data synchronization from gateway, database server, data analysis, data visualization.

奶牛监测系统主要包含下面三部分：
1、传感器节点。目录是xnode
	包含：加速度传感器，2.4GHz无线射频收发器，125KHz无线低频接收器，msp430微控制器。
2、数据转发网关。目录是gateway
	包含：无线射频收发器的驱动程序，spi总线驱动程序，多线程网关监听节点通信服务程序，网关和服务器之间的数据同步脚本程序。
3、数据分析服务器。目录是server
	包含：同步网关数据脚本程序，数据库服务程序，数据分析程序，数据可视化程序。