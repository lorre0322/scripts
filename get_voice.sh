#!/bin/sh
# Prints the current volume or 🔇 if muted.
case $BUTTON in
	1) amixer set Master toggle;;
	4) amixer set Master 5%+ ;;
	5) amixer set Master 5%- ;;
esac

MUTED=$(amixer get Master | grep off)
VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
# MUTED=$(pamixer --get-mute)
# VOL=$(pamixer --get-volume)

# 判断是否静音
if [ "$MUTED" ] || [ "$VOL" -eq 0 ] ;then
    printf " 婢 $VOL%s%%"
elif [ "$VOL" -ge 1 ] && [ "$VOL" -le 32 ]; then
    printf "  $VOL%s%%"
elif [ "$VOL" -gt 32 ] && [ "$VOL" -le 70 ]; then
    printf " 墳 $VOL%s%%"
else
    printf " 墳 $VOL%s%%"
fi
