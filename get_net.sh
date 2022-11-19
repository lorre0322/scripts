#!/bin/sh
#
update() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

RX=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
TX=$(update /sys/class/net/[ew]*/statistics/tx_bytes)

# 换算单位
# 如果 接收/发送 小于 1024/大于1048576 换算单位
# 同理把复制把RX改成TX就是上传速度
# 下载
if [ $RX -gt -1 ] &&  [ $RX -lt 1024 ] ;then
	RX=$(echo $RX | awk '{print $1 "B/s"}')
elif [ $RX -ge 1048576];then
	RX=$(echo $RX | awk '{printf("%0.2fMB/s,$1/1048576")}')
else
	RX=$(echo $RX | awk '{printf("%0.2fKB/s", $1/1024)}')
#  RX=$(echo $RX | awk '{printf("%0.2fKB/s", $1/1024")}')
fi


printf "  $RX"
