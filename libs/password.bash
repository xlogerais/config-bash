#!/bin/bash

encpasswd() {
        local password_clear=$1
        local password_md5hash=$(openssl passwd -1 "$password_clear")
        local password_sha1=$(echo -n "$password_clear" | openssl dgst -sha1)
        echo "Password : $password_clear"
        echo "MD5HASH  : $password_md5hash"
        echo "SHA1  : $password_sha1"
}

genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=12
        local password_clear=$(tr -dc A-Za-z0-9_ </dev/urandom | head -c "${l}" | xargs)
        local password_md5hash=$(openssl passwd -1 "$password_clear")
        local password_sha1=$(echo -n "$password_clear" | openssl dgst -sha1)
        local password_base64=$(echo -n "$password_clear" | base64)
        echo "Password : $password_clear"
        echo "Base64 : $password_base64"
        echo "MD5HASH  : $password_md5hash"
        echo "SHA1  : $password_sha1"
}
