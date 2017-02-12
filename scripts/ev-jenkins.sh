#!/bin/bash
function ev-jenkins(){
	__doc__ 本地jenkins服务控制命令
case "$1" in
"" | -h )
	echo "Usage: ev-jenkins [init | start | stop | open]"
	echo
	;;
"init" )
	mkdir -p $_EV_HOME/volumns/jenkins
	docker stop ev-jenkins
	docker rm ev-jenkins
	docker run --network=ev-network --ip 192.168.1.111 -d --name ev-jenkins -p 8080:8080 -p 50000:50000 -v $_EV_HOME/volumns/jenkins_home:/var/jenkins_home jenkins
;;
"start" )
	docker start ev-jenkins
;;
"stop" )
	docker stop ev-jenkins
;;
"open" )
	echo "use <admin:admin> login ...."
	open http://127.0.0.1:8080
;;
esac	
}
complete -W "init start stop open" ev-jenkins
