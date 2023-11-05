#!/bin/bash

DEBUG=""
case "$1" in
	-v|--verbosity)
		DEBUG="$1 $2"
		shift
		shift
		;;
	-v*|--verbosity=*)
		DEBUG="$1"
		;;
esac


# shellcheck disable=SC2086
if ! /usr/local/bin/vdirsyncer $DEBUG discover "$@"; then
	echo "discovery failed - sleeping 120s for you to maybe fix it"
	sleep 120
	exit 1
fi

until false
do
   # shellcheck disable=SC2086
   /usr/local/bin/vdirsyncer $DEBUG sync "$@"

   test -x /home/vds/post-sync-hook.sh && bash /home/vds/post-sync-hook.sh

   sleep "${VDIRSYNCER_INTERVAL:-900}"
done
