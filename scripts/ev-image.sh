#!/bin/bash
. $_EV_HOME/scripts/libs

function ev-image(){
	__doc__ docker image 配置文件管理
	cd $_EV_HOME/volumns/image
	case "$1" in
	"" | -h )
		echo "Usage: ev-image [list | add | rm ]"
		echo
	;;
	"list" )
		for f in  * ; do
			if [ -d $f ]; then
				echo $f
			fi			
		done	
	;;
	"add" )
		shift
		mkdir -p $_EV_HOME/volumns/image/$1
		touch $_EV_HOME/volumns/image/$1/Dockerfile
	;;
	"rm" )
		shift
		for f in $@ ; do 
		rm -rf $_EV_HOME/volumns/image/$f
		done
	;;
	* )
		cd $1
	;;
	esac	
}
complete -W "list add rm" ev-image
