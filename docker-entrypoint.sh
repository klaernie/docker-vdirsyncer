#!/bin/bash

/usr/local/bin/vdirsyncer discover "$@" || exit 1
until false
do
   /usr/local/bin/vdirsyncer sync "$@"
   sleep ${VDIRSYNCER_INTERVAL:-900}
done
