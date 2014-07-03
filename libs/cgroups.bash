#!/bin/bash

# Use cgroups
if [ "$PS1" ] ; then

	if [ -d /sys/fs/cgroup ] ; then
		cdir=/sys/fs/cgroup
	elif [ -d /dev/cgroup ]; then
		cdir=/dev/cgroup
	fi

	if [ -n "$cdir/user" ]; then
		mkdir -p -m 0700 $cdir/user/$$ > /dev/null 2>&1
		/bin/echo $$ > $cdir/user/$$/tasks
		/bin/echo '1' > $cdir/user/$$/notify_on_release
		unset -v cdir
	fi

fi
