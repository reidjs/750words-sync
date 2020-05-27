#!/bin/bash
# Move this file to /usr/local/bin/?
# Set cron to run every x seconds/hours/days

lastSyncFile=".last-sync"
if [ ! -f "$lastSyncFile" ]; then
  touch $lastSyncFile
fi
# Grab first line of sync record file
lastSyncDate=$(head -n 1 ${lastSyncFile})
# Grab second line of sync record file
lastEditTime=$(sed -n '2p' < ${lastSyncFile})

TODAY=$(date +"%b %d, %Y")
NOW=$(date)
lastTimeWorkFileModified=$(date -r TODAY.md)

function updateSyncFile {
  lastSyncDate=$TODAY
  lastEditTime=$lastTimeWorkFileModified

  echo "${lastSyncDate}" > "${lastSyncFile}"
  echo "${lastEditTime}" >> "${lastSyncFile}"
}

echo "Attempting sync ${NOW}" >> .log

# If work file not modified since last sync, exit
if [ "$lastEditTime" == "$lastTimeWorkFileModified" ]; then
  echo "No need to run sync, file not editted" >> .log
  echo "" >> .log
  exit 1
fi

# Was not able to set these variables, so update the sync file
if [ -z "$lastSyncDate" ] || [ -z "$lastEditTime" ]; then
  updateSyncFile
fi

echo "Last sync date: ${lastSyncDate}" >> .log

archiveFile="ARCHIVE/${TODAY}.md"

# copy text from working file to archive file
cp TODAY.md "${archiveFile}"

echo "Archived today's work into ${archiveFile}" >> .log

# Sync text from working file to 750words.com
NODEDIR=$(which node)
$NODEDIR uploadText.js
echo "Sync'd today's work to 750words.com" >> .log
echo "" >> .log

# If current day is different the last sync date
if [ "$lastSyncDate" != "$TODAY" ]; then
  # clears today's file
  > TODAY.md
fi

# update last sync time/date in file
updateSyncFile