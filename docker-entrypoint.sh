#!/bin/bash

DEBUG=""
case "$1" in
	-v:
	--verbosity:
		DEBUG="$1 $2"
		shift
		shift
		;;
	-v*:
	--verbosity=*:
		DEBUG="$1"
		;;
esac


/usr/local/bin/vdirsyncer $DEBUG discover "$@" || exit 1
until false
do
   /usr/local/bin/vdirsyncer $DEBUG sync "$@"
   sleep "${VDIRSYNCER_INTERVAL:-900}"
done
