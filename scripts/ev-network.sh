#!/bin/bash

function ev-network(){
__doc__ 
echo 'please complete command: network'
}

function ev-network(){
	__doc__ docker network 控制命令
	case "$1" in
	"" | -h )
		echo "Usage: ev-network [create | remove | ls]"
		echo
		;;
	"create" )
		docker network create --subnet=192.168.1.0/24 --gateway=192.168.1.1 --ip-range=192.168.1.0/24 ev-network
	;;
	"remove" )
		docker network rm ev-network
	;;
	"ls" )
		docker network inspect ev-network | jq ".[0].Containers | to_entries | del(.[].value.EndpointID) | del(.[].value.MacAddress) | del(.[].value.IPv6Address) | .[].value"
	;;
	esac	
}
complete -W "create remove ls" ev-network

