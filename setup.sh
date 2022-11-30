#!/bin/bash

#console colors
red_color=`tput setaf 1`
violet=`tput setaf 125`
reset_color=`tput sgr0`

pattern=$(cat <<-END

███████ ███████ ███████ ████████ ██   ██ ███████ ███    ███  █████  ██      ██
██      ██      ██         ██    ██   ██ ██      ████  ████ ██   ██ ██      ██
███████ █████   █████      ██    ███████ █████   ██ ████ ██ ███████ ██      ██
     ██ ██      ██         ██    ██   ██ ██      ██  ██  ██ ██   ██ ██      ██
███████ ███████ ███████    ██    ██   ██ ███████ ██      ██ ██   ██ ███████ ███████


END
)

function START_SCRIPT(){


(cd /home/$(whoami)/Downloads/seethem/&& python3 main.py)

}


echo "${red_color}${pattern}"
echo ""
echo "${violet}>> --scan = scans for online hosts on your network.${reset_color}"

read answer


if [ $answer == "--scan" ] ; then
  echo ""
	echo ""
	sleep 2
START_SCRIPT
fi
 exit
