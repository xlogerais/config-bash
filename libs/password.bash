#!/bin/bash

encpasswd() {
      	local password_clear=$1
        local password_md5hash=$(openssl passwd -1 $password_clear)
        echo "Password : $password_clear"
        echo "MD5HASH  : $password_md5hash"
}

genpasswd() {
	local l=$1
       	[ "$l" == "" ] && l=12
      	local password_clear=$(tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs)
        local password_md5hash=$(openssl passwd -1 $password_clear)
        echo "Password : $password_clear"
        echo "MD5HASH  : $password_md5hash"
}
