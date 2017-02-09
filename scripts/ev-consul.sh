#!/bin/bash
. $_EV_HOME/scripts/libs

function ev-consul(){
	__doc__ 服务发现管理命令
	case "$1" in
	"" | -h )
		echo "Usage: ev-consul [init | start | stop]"
		echo
		;;
	"init" )
		docker stop ev-consul
		docker rm ev-consul
		docker run -d --name=ev-consul -p 127.0.0.1:8300:8300 -p 127.0.0.1:8500:8500 -p 127.0.0.1:8600:8600 consul
		#docker run -d --name ev-redis -v $_EV_HOME/volumns/redis:/data -p 127.0.0.1:6379:6379 redis
	;;
	"start" )
		# docker start ev-consul
		consul agent -dev
	;;
	"stop" )
		docker stop ev-consul
	;;
	esac	
}
complete -W "init start stop" ev-consul

