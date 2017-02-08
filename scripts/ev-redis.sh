#!/bin/bash
. $_EV_HOME/scripts/libs

function ev-redis(){
	__doc__ 本地 redis 服务控制命令
	case "$1" in
	"" | -h )
		echo "Usage: ev-redis [init | start | stop | cli]"
		echo
		;;
	"init" )
		docker stop ev-redis
		docker rm ev-redis
		docker run -d --name ev-redis -v $_EV_HOME/volumns/redis:/data -p 127.0.0.1:6379:6379 redis
	;;
	"start" )
		docker start ev-redis
	;;
	"stop" )
		docker stop ev-redis
	;;
	"cli" )
		redis-cli
	;;
	esac	
}
complete -W "init start stop cli" ev-redis
