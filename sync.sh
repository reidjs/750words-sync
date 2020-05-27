#!/bin/bash
# Move this file to /usr/local/bin/
# Set cron to run every x seconds/hours/days

# https://stackoverflow.com/questions/16391208/print-a-files-last-modified-date-in-bash
# Store last time file modified in file (date -r)
# If TODAY.md has been modified since last time script run, run JS file to update changes to website (index.js)
# If today date is after date of file creation, mv TODAY.md to Archive Dir and rename it to today's date "March 1, 2020.md", Create a new TODAY.md in folder

lastSyncFile=".last-sync"
if [ ! -f "$lastSyncFile" ]; then
  touch $lastSyncFile
fi
# First line of file
lastSyncDate=$(head -n 1 ${lastSyncFile})
# 2nd line of file
lastSyncTime=$(sed -n '2p' < ${lastSyncFile})

TODAY=$(date +"%b %d, %Y")
NOW=$(date)
# file is empty, so set last sync date to now

function updateSyncFile {
  lastSyncDate=$TODAY
  lastSyncTime=$NOW
  echo "${lastSyncDate}" > "${lastSyncFile}"
  echo "${lastSyncTime}" >> "${lastSyncFile}"
}

if [ -z "$lastSyncDate" ] || [ -z "$lastSyncTime" ]; then
  updateSyncFile
fi

# echo "previous sync date: ${lastSyncDate}"
echo "Last sync: ${lastSyncTime}" >> .log

# fancyDate=$(date +"%b %d, %Y")
# echo "fancy date: ${fancyDate}"

archiveFile="ARCHIVE/${TODAY}.md"

# copy text from today's doc to archive file 
cp TODAY.md "${archiveFile}"

echo "Archived today's work into ${archiveFile}" >> .log

# TODO: sync text in TODAY.md to 750words.com
npm start
echo "Sync'd today's work to 750words.com" >> .log
echo "" >> .log

# If current day is different the last sync date
if [ "$lastSyncDate" != "$TODAY" ]; then
  # clears today's file
  > TODAY.md
fi

# update last sync time/date in file
updateSyncFile