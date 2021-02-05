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
/usr/local/bin/vdirsyncer $DEBUG discover "$@" || exit 1
until false
do
   # shellcheck disable=SC2086
   /usr/local/bin/vdirsyncer $DEBUG sync "$@"

   test -x /home/vds/post-sync-hook.sh && bash /home/vds/post-sync-hook.sh

   sleep "${VDIRSYNCER_INTERVAL:-900}"
done
