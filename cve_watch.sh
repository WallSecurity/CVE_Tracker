#!/bin/bash
CVE_WATCHLIST='/root/Logs/CVE_watchlist/watchlist.txt'
CVE_LIST='/root/Logs/CVE_watchlist/cvelist.txt'
CVE_DIR='/opt/cvelistV5/cves/'
CVE=$1

dateNow=`date`
res=`find $CVE_DIR -name "$CVE.json" | wc -l`

cd /opt/cvelistV5/ && git pull

if [ $res -eq 1 ]; then
	echo $CVE | anew $CVE_WATCHLIST
	exit 0
else
	exit 1
fi
