#!/bin/bash

case "$1" in
"" | -h )
	echo "Usage: ev mysql [init | start | attach]"
	echo
	;;
"init" )
	docker stop ev-mysql
	docker rm ev-mysql
	docker run --name ev-mysql -v $_EV_HOME/volumns/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -p 127.0.0.1:3306:3306 -d mysql:5.7
;;
"start" )
	docker start ev-mysql
;;
"stop" )
	docker stop ev-mysql
;;
"attach" )
	docker exec -i -t ev-mysql bash
;;
esac
