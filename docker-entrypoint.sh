#!/bin/bash

/usr/local/bin/vdirsyncer discover || exit 1
until false
do
   /usr/local/bin/vdirsyncer sync
   sleep 900
done
