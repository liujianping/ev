#!/bin/bash
. $_EV_HOME/scripts/libs

function _gen_config(){
	cat <<EOF > ~/.config/memo/config.toml 
memodir = "$_EV_HOME/volumns/memo/posts"
editor = "subl"
column = 20
selectcmd = "peco"
grepcmd = "grep -nH ${PATTERN} ${FILES}"
assetsdir = "$_EV_HOME/volumns/memo/"
EOF
}

function ev-memo(){
	__doc__ 本地 memo 命令
	case "$1" in
	-h )
		echo "Usage: ev-memo [init]"
		echo
		;;
	"" )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin	
		cd $_EV_HOME/volumns/memo/
	;;
	"init" )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin
		mkdir -p $_EV_HOME/volumns/memo/
		mkdir -p $_EV_HOME/volumns/memo/posts
		go get github.com/mattn/memo
		_gen_config
		;;
	* )
		export GOPATH=$_EV_HOME/volumns/github
		export PATH=$PATH:$GOPATH/bin
		memo $@
	;;
	esac	
}
complete -W "init " ev-md
