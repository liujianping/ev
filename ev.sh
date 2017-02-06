#!/bin/bash

if [[ "$BASH_SOURCE[0]" == "" ]]; then
	export _EV_HOME=$(cd $(dirname $0) 2>&1 >/dev/null; pwd)
else
	export _EV_HOME=$(cd $(dirname $BASH_SOURCE[0]) 2>&1 >/dev/null; pwd)
fi

_ev_init_() {
	_debug_off_
	if [[ "$_ev_inited" != "" ]]; then
		return 0
	fi
	mkdir -p $_EV_HOME/scripts
	mkdir -p $_EV_HOME/volumns
	if [[ "$_ev_slogan" != "0" ]]; then
	echo
	echo "+-+-+-+-+-+-+-+-+-+-+		";
	echo "|ev home => $_EV_HOME		";
	echo "+-+-+-+-+-+-+-+-+-+-+		";
	echo
	fi
	#source $_dockerize_home/scripts/env.sh
	export _ev_inited=1
}

_ev_exec_() {
	$@
	ret=$?
	if [[ "$ret" == "0" ]]; then
		return 0
	fi
	exit $ret
}

_debug_on_(){
	export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
	set -x
}

_debug_off_(){
	set +x
}

_add_command_(){
	for i in "$@"; do
	    cmd=$_EV_HOME/scripts/ev-$i.sh
	    if [ -e "$cmd" ]; then
	    	echo "sorry, $i already exist."	
	    fi
	    touch $cmd
	    chmod +x $cmd
	    echo "#!/bin/bash" >> $cmd
	    echo "echo 'please complete command: $i'" >> $cmd
	done
}

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
		_ev_exec_ cd $_EV_HOME
		;;
	-v | --version )
		_ev_exec_ echo "ev version 0.0.1"
		;;
	"add" )
		shift
		_add_command_ $@
		;;
	* )
		command_path=$_EV_HOME/scripts/ev-$command.sh
		if [ -x "$command_path" ]; then
			shift
			_ev_exec_ $command_path $@
			return 
		fi
		
		echo "unsupport command: $command"
	esac
}


function mysql-cli(){
	mysql -h127.0.0.1 -P3306 -uroot -p123456
}
