#!/bin/bash

function ip_to_hex ()
{
	if test -e "$1" ; then echo "Usage : $0 XXX.XXX.XXX.XXX" ; return ; fi
	IFS='.' read -a array <<< "$1"
	printf "%02X %02X %02X %02X \n" ${array[0]} ${array[1]} ${array[2]} ${array[3]}
}

function generate_mac_from_ip ()
{
	if test -e "$1" ; then echo "Usage : $0 hostname" ; return ; fi
	IFS='.' read -a array <<< "$1"
	printf "    IP HEXA : %02X %02X %02X %02X\n" ${array[0]} ${array[1]} ${array[2]} ${array[3]}
	printf "        MAC : 52:54:00:%02X:%02X:%02X\n" ${array[1]} ${array[2]} ${array[3]}
	printf "DHCP CONFIG : host $1	{ hardware ethernet 52:54:00:%02X:%02X:%02X; }\n" ${array[1]} ${array[2]} ${array[3]}
}

function generate_mac_from_hostname ()
{
	if test -e "$1" ; then echo "Usage : $0 hostname" ; return ; fi
	IFS='.' read -a array <<< "$(ssh admin dig +search +short $1)"
	printf "    IP HEXA : %02X %02X %02X %02X\n" ${array[0]} ${array[1]} ${array[2]} ${array[3]}
	printf "        MAC : 52:54:00:%02X:%02X:%02X\n" ${array[1]} ${array[2]} ${array[3]}
	printf "DHCP CONFIG : host $1	{ hardware ethernet 52:54:00:%02X:%02X:%02X; }\n" ${array[1]} ${array[2]} ${array[3]}
}
