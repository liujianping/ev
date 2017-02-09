#!/bin/bash
. $_EV_HOME/scripts/libs

function ev-registry(){
	__doc__ 本地 registry 服务控制命令
	case "$1" in
	"" | -h )
		echo "Usage: ev-registry [init | start | stop]"
		echo
		;;
	"init" )		
		docker stop ev-registry
		docker rm ev-registry
		docker run --network=ev-network --ip 192.168.1.110 -d --name ev-registry -p 127.0.0.1:5000:5000 -v $_EV_HOME/volumns/registry:/var/lib/registry registry:2
	;;
	"start" )
		docker start ev-registry
	;;
	"stop" )
		docker stop ev-registry
	;;
	esac	
}
complete -W "init start stop" ev-registry
