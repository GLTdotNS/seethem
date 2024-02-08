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
info="This app aims to scan your private network. The commands are listed below "
version="                v1.0"

function START_SCRIPT(){


(cd /home/$(whoami)/PycharmProjects/seethem/&& python3 main.py)

}
function Kicker(){
(cd /home/$(whoami)/PycharmProjects/seethem/Kicker/ && sudo python3 Kicker.py)



}


echo "${red_color}${pattern}"
echo "${reset_color}${version}"
echo "${info}"
echo ""
echo "${violet}>> --scan = online hosts on your network."
echo ">> --exit = exit app. ${reset_color}"
printf "Enter the command ==> "
read answer

while [ answer != "--exit" ]; do

    if [ $answer == "--scan" ] ; then
  echo ""
	sleep 2
START_SCRIPT
  echo ""
 printf "${reset_color}Enter the command ==> "
  read answer

  elif [ $answer == "--exit"  ]; then
  exit

  elif [ $answer == "--kick"  ]; then


    Kicker
  exit


   else
    echo "unknown command"
    printf "Enter the command =>> ${reset_color}"
    read answer
fi
done


