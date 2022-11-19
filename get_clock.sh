#!/bin/sh

# clock=$(date '+%I')

case $BUTTON in
	1) notify-send "==   Calendar ==" "$(cal --color=always | sed "s/..7m/<b><span color=\"yellow\">/;s/..27m/<\/span><\/b>/")"  ;;
esac

LOCALTIME=$(date +"  %H:%M ")
printf "${LOCALTIME}"

