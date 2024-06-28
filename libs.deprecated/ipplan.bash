#!/bin/bash

function ipplan_search_by_ip()
{
	echo "select inet_ntoa(ipaddr) as ip, location, hname, descrip, userinf from ipaddr where ipaddr = inet_aton('$1');" | ssh virt-cha-nettools mysql --database ipplan --default-character-set=latin1 --table
}

function ipplan_search_by_location()
{
	echo "select inet_ntoa(ipaddr) as ip, location, hname, descrip, userinf from ipaddr where location like '%$1%';" | ssh virt-cha-nettools mysql --database ipplan --default-character-set=latin1 --table
}

function ipplan_search_by_name()
{
	echo "select inet_ntoa(ipaddr) as ip, location, hname, descrip, userinf from ipaddr where hname like '%$1%';" | ssh virt-cha-nettools mysql --database ipplan --default-character-set=latin1 --table
}

function ipplan_search_by_desc()
{
	echo "select inet_ntoa(ipaddr) as ip, location, hname, descrip, userinf from ipaddr where descrip like '%$1%';" | ssh virt-cha-nettools mysql --database ipplan --default-character-set=latin1 --table
}

function ipplan_search_by_user()
{
	echo "select inet_ntoa(ipaddr) as ip, location, hname, descrip, userinf from ipaddr where userinf like '%$1%';" | ssh virt-cha-nettools mysql --database ipplan --default-character-set=latin1 --table
}

function ipplan_list_ingesys()
{
	echo "select inet_ntoa(ipaddr) as ip, location, hname, descrip, userinf from ipaddr where userinf like '%ing%sys%'; " | ssh virt-cha-nettools mysql --database ipplan --default-character-set=latin1 --table
}
