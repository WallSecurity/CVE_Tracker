#!/bin/bash
CVE_WATCHLIST="/root/Logs/CVE_watchlist/watchlist.txt"
CVE_TESTLIST="/root/Logs/CVE_watchlist/testlist.txt"
CVE_LIST='/root/Logs/CVE_watchlist/cvelist.txt'
CVE_DIR="/opt/cvelistV5/cves/"
NOTIFY_CONFIG="/root/.config/notify/provider-config_cvetracker.yaml"
while read cve;
do
	cve_file=`find $CVE_DIR -name "$cve.json"`
	date_published=`cat $cve_file | jq -r .cveMetadata.datePublished | cut -d 'T' -f 1`
	isTestable=`python3 /usr/bin/cve_timecheck $date_published 30`
	if [ $isTestable = "True" ]; 
	then 
		echo $cve | anew $CVE_TESTLIST | notify -pc $NOTIFY_CONFIG
		sed -i "/${cve}/d" $CVE_WATCHLIST
	fi	
done < $CVE_WATCHLIST
