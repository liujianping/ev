#!/bin/bash
case "$1" in
"" | -h )
	echo "Usage: ev redis [init | start | stop | redis]"
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
"attach" )
	docker exec -i -t ev-redis bash
;;
esac
