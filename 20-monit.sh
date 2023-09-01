#!/bin/sh -eu
# Monit Download Script 1.0.1, (c) 2022 Ma_Sys.ma <info@masysma.net>.
# Open with firefox "jar:file://$(pwd)/monit0.war!/index.html"

port="$(grep -F "set httpd port" /etc/monit/conf.d/* | tr ' ' '\n' | \
				grep -E '^[0-9]+$' || true)"
user_password="$(grep -E "allow [^:]+:\"[^ ]+\"" /etc/monit/conf.d/* | \
			tr ' ' '\n' | grep -E "[^:]+:\"[^ ]+\"" || true)"
user="${user_password%%:*}"
password="$(printf "%s" "${user_password#*:}" | cut -c 2- | head -c -2)"

if [ -z "$port" ]; then
	echo "monit: unknown port" > monit_error.txt
	exit 0
fi

[ -z "$user"     ] || user="--http-user=$user"
[ -z "$password" ] || password="--http-password=$password"

mkdir "dl$$"
cd "dl$$"
rc=0
wget --tries=2 $user $password --local-encoding=UTF-8 \
	--no-host-directories --adjust-extension --recursive \
	--convert-links --page-requisites \
	--domains=127.0.0.1 "http://127.0.0.1:$port/" \
	> wgetlog.txt 2>&1 || rc=$?
if zip "../monit$rc.war" * > ziplog.txt 2>&1; then
	rm ziplog.txt
else
	mv ziplog.txt ../monit_error_zip.txt
fi
cd ..
rm -r "dl$$"
