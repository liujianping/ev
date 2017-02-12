#!/bin/bash

function ev-github(){
	__doc__ 切换到github开发环境命令
	case "$1" in
	-h )
		echo "Usage: ev-github [init | clone | get]"
		echo
		;;
	"" )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin
		cd $_EV_HOME/volumns/github/src/github.com/liujianping
	;;	
	"init" )
		mkdir -p $_EV_HOME/volumns/github/
		;;
	"clone" )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin
		shift
		cd $_EV_HOME/volumns/github/
		git clone $@
		;;
	"get" )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin
		shift
		go get $@
		;;
	* )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin
		cd $GOPATH/src/$@
		;;
	esac	
}
complete -W "init clone get" ev-github
