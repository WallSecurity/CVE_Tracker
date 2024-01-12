#!/bin/bash
GITHUB_CVE_DIR='/opt/cvelistV5'
CVE_DIR='/opt/cvelistV5/cves'
CVE_LIST='/root/Logs/CVE_watchlist/cvelist.txt'

SEARCHDATE=`date "+%Y-%m-%d"`
CURRENTYEAR=`date +%Y`
LASTYEAR=`date --date="1 year ago" +%Y`

if [ "$#" -eq 1 ]; then
	SEARCHDATE=$1
fi

# update repository
cd $GITHUB_CVE_DIR && git pull -q
echo "Searching for CVEs released on: $SEARCHDATE"
for cve in $(find $CVE_DIR/{$LASTYEAR,$CURRENTYEAR} -type f -name "CVE-*.json");
do
	datePublished=`cat $cve | jq -r .cveMetadata.datePublished | cut -d 'T' -f 1`
	if [ "$datePublished" = "$SEARCHDATE" ]; then
		echo $cve
	fi
done

echo ""

# TODO
# 1. check for new CVEs with git (status, pull?) --> SEE SCREENSHOT
#	--> Newly added files start the line with "create"
#	--> Too many CVEs added over the day - we need to figure out the structure first and filter prior to tracking
# 2. send new CVEs to discord
	# basically this script is just 1. + 2., we're done here
	# 3. implement function to add CVE to watchlist from discord - DONE
	# 4. continously monitor watchlist to identify CVEs being published for 30 days - DONE
	# 5. ping discord / auto run on specific targets / etc - DONE
