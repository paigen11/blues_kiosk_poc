#!/bin/bash

function req {
	while [ true ]
	do
		RSP=`$NOTECARD $1`
		ERR=`echo $RSP | jq .err 2>/dev/null`
		if [[ "$ERR" == null ]]; then
		    break
		fi
		echo "retrying request..."
		sleep 1
	done
}