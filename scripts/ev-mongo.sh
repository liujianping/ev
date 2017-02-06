#!/bin/bash
case "$1" in
"" | -h )
	echo "Usage: ev mongo [init | start | stop | attach]"
	echo
	;;
"init" )
	docker stop ev-mongo
	docker rm ev-mongo
	#docker run -d --name ev-mongo -v $_EV_HOME/volumns/mongo:/data/db -p 127.0.0.1:27017:27017 mongo:3.2
	docker run -d --name ev-mongo -v $_EV_HOME/volumns/mongo:/data/db -p 127.0.0.1:27017:27017 mongo:3.4
;;
"start" )
	docker start ev-mongo
;;
"stop" )
	docker stop ev-mongo
;;
"attach" )
	docker exec -i -t ev-mongo bash
;;
esac

