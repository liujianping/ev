#!/bin/bash
shopt -s nullglob

for file in $(find "$_EV_HOME/scripts" -name "*.sh"); do
  command="${file##*ev-}"
  echo ${command%.sh}
done | sort | uniq
