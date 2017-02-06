#!/bin/bash

# gitlab default user/pass: root/5iveL!fe
# change => root/kiss1*7*1
function ev-gitlab(){
	__doc__ 本地 gitlab 服务控制命令
case "$1" in
"" | -h )
	echo "Usage: ev-gitlab [init | start | stop | attach]"
	echo
	;;
"init" )
	mkdir -p $_EV_HOME/volumns/gitlab/data
	mkdir -p $_EV_HOME/volumns/gitlab/data/gitlab
	mkdir -p $_EV_HOME/volumns/gitlab/data/postgresql
	mkdir -p $_EV_HOME/volumns/gitlab/data/redis
	
	docker stop ev-gitlab
	docker stop ev-gitlab-postgresql
	docker stop ev-gitlab-redis
	
	docker rm ev-gitlab
	docker rm ev-gitlab-postgresql
	docker rm ev-gitlab-redis

	docker run --name=ev-gitlab-postgresql -d -e 'DB_NAME=gitlabhq_production' -e 'DB_USER=gitlab' -e 'DB_PASS=password' -v $_EV_HOME/volumns/gitlab/data/postgresql:/var/lib/postgresql sameersbn/postgresql:9.4
	docker run --name=ev-gitlab-redis -d sameersbn/redis:latest
	docker run --name=ev-gitlab -d \
	--link ev-gitlab-redis:redisio \
	--link ev-gitlab-postgresql:postgresql \
	-v $_EV_HOME/volumns/gitlab/data/gitlab:/home/git/data \
	-p 10022:22 -p 10080:80 \
	-e 'GITLAB_HOST=localhost' \
	-e 'GITLAB_PORT=10080' \
	-e 'GITLAB_SSH_PORT=10022' \
	-e 'GITLAB_EMAIL=liujianping.itech@qq.com' \
	-e 'GITLAB_ROOT_PASSWORD=123456' \
    -e 'GITLAB_ROOT_EMAIL=liujianping.itech@qq.com' \
	-e 'GITLAB_BACKUPS=daily' \
	-e 'GITLAB_SIGNUP=true' \
	-e 'GITLAB_GRAVATAR_ENABLED=false' \
	sameersbn/gitlab:7.11.2
;;
"start" )
	docker start ev-gitlab-redis
	docker start ev-gitlab-postgresql
	docker start ev-gitlab
;;
"stop" )
	docker stop ev-gitlab
	docker stop ev-gitlab-postgresql
	docker stop ev-gitlab-redis
;;
"attach" )
	docker exec -i -t ev-gitlab bash
;;
esac	
}

