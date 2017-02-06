#!/bin/bash
case "$1" in
"" | -h )
	echo "Usage: ev jenkins [init | start | stop | attach]"
	echo
	;;
"init" )
	mkdir -p $_EV_HOME/volumns/jenkins
	docker stop ev-jenkins
	docker rm ev-jenkins
	docker run -d --name ev-jenkins -p 8080:8080 -p 50000:50000 -v $_EV_HOME/volumns/jenkins_home:/var/jenkins_home jenkins
	echo "please input: docker attach ev-jenkins , to find the init password"
;;
"start" )
	docker start ev-jenkins
	echo "jenkins: http://localhost:8080"
;;
"stop" )
	docker stop ev-jenkins
;;
"attach" )
	docker exec -i -t ev-jenkins bash
;;
esac
