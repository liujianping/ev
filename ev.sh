#!/bin/bash

if [[ "$BASH_SOURCE[0]" == "" ]]; then
	export _EV_HOME=$(cd $(dirname $0) 2>&1 >/dev/null; pwd)
else
	export _EV_HOME=$(cd $(dirname $BASH_SOURCE[0]) 2>&1 >/dev/null; pwd)
fi
export __exec="eval"

. $_EV_HOME/scripts/libs

_ev_complete_() {
  COMPREPLY=( $(compgen -W "$(ev commands)" -- "$word") )
}
complete -F _ev_complete_ ev

function ev() {
	_ev_init_

	case "$1" in
	-d | --de*)
	  _debug_on_
	  shift	  
	esac

	command="$1"
	case "$command" in 
	"" )
		$__exec "cd $_EV_HOME"
		;;
	-v | --version )
		$__exec "echo 'ev version 0.0.1'"
		;;
	"add" )
		shift
		_add_command_ $@
		;;
	"rm" )
		shift
		_rm_command_ $@
		;;
	* )
		command_path=$_EV_HOME/scripts/ev-$command.sh
		if [ -x "$command_path" ]; then
			. $command_path
			shift
			eval "ev-$command $@"
			#eval "$command_path $@"
			return 
		fi
		
		echo "unsupport command: $command"
	esac
}

function ev-help(){
	__doc__ 显示辅助函数
	declare -f | egrep '^ev-\w+' -A 1 | awk 'BEGIN{name=""; doc=""} /--/ {print name"\t"doc; doc=""; name=""} /__doc__/ {for(i=2;i<=NF;i++) doc=doc" "$i} /\(\)/ {name=$1} END{print name"\t"doc}' | column -t -s "	"| sort 
}


