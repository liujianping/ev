#!/bin/bash
function ev-mongo(){
	__doc__ 本地mongo服务控制命令
case "$1" in
"" | -h )
	echo "Usage: ev-mongo [init | start | stop]"
	echo
	;;
"init" )
	docker stop ev-mongo
	docker rm ev-mongo
	#docker run -d --name ev-mongo -v $_EV_HOME/volumns/mongo:/data/db -p 127.0.0.1:27017:27017 mongo:3.2
	docker run --network=ev-network --ip 192.168.1.102 -d --name ev-mongo -v $_EV_HOME/volumns/mongo:/data/db -p 127.0.0.1:27017:27017 mongo:3.4
;;
"start" )
	docker start ev-mongo
;;
"stop" )
	docker stop ev-mongo
;;
esac	
}
complete -W "init start stop cli" ev-mongo


