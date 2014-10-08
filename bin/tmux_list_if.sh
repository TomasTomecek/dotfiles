#!/bin/sh
line=""
for i in $(ls -1 /sys/class/net) ; do
    if [ "$i" != "lo" ] ; then
        addr=$(ip -4 -o a s $i | awk '{ print $4 }')
        if [ -n "$addr" ] ; then
            i_clean=$(echo "$i" | sed -e 's/wlp\w*/W/g' -e 's/enp\w*/E/g' -e 's/tun\w+/V/g')
            if [ "$i_clean" == "W" ] ; then
                line="$line#[fg=white]$i_clean #[fg=colour33]$addr "
            fi
            if [ "$i_clean" == "E" ] ; then
                line="$line#[fg=white]$i_clean #[fg=green]$addr "
            fi
            if [ "$i_clean" == "V" ] ; then
                line="$line#[fg=white]$i_clean #[fg=colour166]$addr "
            fi
        fi
    fi
done
echo $line
