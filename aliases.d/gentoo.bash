if [ -f /etc/gentoo-release ]
then
	alias emerge='sudo emerge'
	alias etc-update='sudo etc-update'
	alias revdep-rebuild='sudo revdep-rebuild'
	alias eix='eix -F'
fi
