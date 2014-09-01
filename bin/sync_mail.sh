#!/bin/bash

SLEEP_TIME="${1:-300}"
echo ${SLEEP_TIME}
while true ; do
    BEFORE=$(notmuch count "folder:Inbox tag:unread")
    echo -n "{"
    mbsync -q work
    if [[ ${?} == 0 ]]
    then
        echo -n "+"
        notmuch new --quiet &>/dev/null  # just shut up, please
    fi
    AFTER=$(notmuch count "folder:Inbox tag:unread")
    if [[ ${BEFORE} != ${AFTER} ]] && [[ ${AFTER} > 0 ]]
    then
        echo -n "${AFTER}"
        # print bell
        echo -n $'\x07'
    fi
    echo -n "}"
    sleep ${SLEEP_TIME}
done

