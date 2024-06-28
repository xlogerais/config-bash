#!/bin/bash

function ssh_clean_known_hosts() {
	if [ -z "$1" ]; then
		echo "No arguments given. Cleaning ~/.ssh/known_hosts"
		sed -i -e '/no hostip for proxy command/ d' ~/.ssh/known_hosts
	else
		hostname=$1
		ip=$(ssh admin dig +short "$1")
		echo "Removing host ${hostname} from ~/.ssh/known_hosts"
		sed -i -e "/${hostname}/ d" ~/.ssh/known_hosts
		echo "Removing ip ${ip} from ~/.ssh/known_hosts"
		sed -i -e "/${ip}/ d" ~/.ssh/known_hosts
	fi

}
