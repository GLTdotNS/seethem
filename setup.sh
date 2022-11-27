#!/bin/bash

#console colors
red_color=`tput setaf 1`
violet=`tput setaf 125`
reset_color=`tput sgr0`

pattern=$(cat <<-END
██████╗ ██╗███████╗ ██████╗ ██████╗ ██████╗ ██████╗
██╔══██╗██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔══██╗
██║  ██║██║███████╗██║     ██║   ██║██████╔╝██║  ██║
██║  ██║██║╚════██║██║     ██║   ██║██╔══██╗██║  ██║
██████╔╝██║███████║╚██████╗╚██████╔╝██║  ██║██████╔╝
╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝
██████╗  ██████╗ ████████╗
██╔══██╗██╔═══██╗╚══██╔══╝
██████╔╝██║   ██║   ██║
██╔══██╗██║   ██║   ██║
██████╔╝╚██████╔╝   ██║
╚═════╝  ╚═════╝    ╚═╝v1.2
END
)


function progress_bar(){


echo `tput civis`

for (( i = 0; i <= 100; i++ ))
do

	printf  "\r[$i]"

	for (( j=0 ; j<i; j++ ))
	do
		printf "█"
    done
	sleep 0.01
	done

}

function botie(){


(cd /home/$(whoami)/PycharmProjects/seethem/&& python3 main.py)

}


echo "${red_color}${pattern}"
echo "${violet}Write 'start' to starting botie <3 ${reset_color}"

read answer


if [ $answer == "start" ] ; then
	progress_bar
	echo ""
	sleep 2
	botie
fi
 exit
