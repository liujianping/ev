#!/bin/bash
# shopt -s nullglob

function ev-commands(){	
	__doc__ 本地服务控制命令列表
	for file in $(find "$_EV_HOME/scripts" -name "*.sh"); do
	  command="${file##*ev-}"
	  echo ${command%.sh}
	done | sort | uniq	
}
