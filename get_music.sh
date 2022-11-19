#!/bin/sh

filter(){ mpc | sed "/^volume:/d;s/\\&/&amp;/g;s/\\[paused\\].*/奈/g;/\\[playing\\].*/d" | paste -sd ' '; }
printf "    " ;
mpc status | filter;

pidof -x chkMpdStatus >/dev/null 2>&1 || chkMpdStatus >/dev/null 2>&1 &
case $BUTTON in
	1) mpc toggle | filter ;;
	2) mpc listall | mpc del | mpc add ; notify-send "   歌单已刷新~" ;;
	3) sudo setsid -f st -e ncmpcpp ;;
	4) mpc prev | filter ;;  # scroll up, previous
	5) mpc next | filter ;;  # scroll down, next
esac
