#!/bin/bash
declare -A addresses
line=""
for i in $(ls -1 /sys/class/net) ; do
    if [ "$i" != "lo" ] ; then
        addr=$(ip -4 -o a s $i | awk '{ print $4 }')
        if [ -n "$addr" ] ; then
            i_clean=$(echo "$i" | sed -e 's/wlp\w*/W/g' -e 's/enp\w*/E/g' -e 's/tun\w*/V/g')
            addresses+=([$i_clean]=$addr)
        fi
    fi
done
if [ -n "${addresses[W]}" ] ; then
    line="$line#[fg=white]W #[fg=colour33]${addresses[W]} "
fi
if [ -n "${addresses[E]}" ] ; then
    line="$line#[fg=white]E #[fg=green]${addresses[E]} "
fi
if [ -n "${addresses[V]}" ] ; then
    line="$line#[fg=white]V #[fg=colour166]${addresses[V]} "
fi
echo $line
