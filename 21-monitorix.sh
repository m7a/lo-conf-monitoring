#!/bin/sh -eu
# Monitorix Download Script 1.0.0, (c) 2022 Ma_Sys.ma <info@masysma.net>.
# Open with firefox "jar:file://$(pwd)/monitorix0.war!/index.html"

port="$(grep -E "[^#]*port =" /etc/monitorix/conf.d/* | cut -d"=" -f 2 | \
				tr ' ' '\n' | grep -E '^[0-9]+$' | tail -n 1)"
if [ -z "$port" ]; then
	echo "monit: unknown port" > monitorix_error.txt
	exit 0
fi

mkdir "dl$$"
cd "dl$$"
rc=0
path="monitorix-cgi/monitorix.cgi"
query="mode=localhost&graph=all&when=1week&color=black"
wget --tries=2 --local-encoding=UTF-8 --no-directories \
	--adjust-extension --recursive --convert-links --page-requisites \
	--domains=127.0.0.1 --html-extension \
	"http://127.0.0.1:$port/$path?$query" > wgetlog.txt 2>&1 || rc=$?
mv "monitorix.cgi?$query.html" index.html || true
if zip "../monitorix$rc.war" * > ziplog.txt 2>&1; then
	rm ziplog.txt
else
	mv ziplog.txt ../monitorix_error_zip.txt
fi
cd ..
rm -r "dl$$"
