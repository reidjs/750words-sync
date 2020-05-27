#!/bin/bash
# Move this file to /usr/local/bin/?
# Set cron to run every x seconds/hours/days

DIR=$1

lastSyncFile="${DIR}/.last-sync"
logFile="${DIR}/.log"
if [ ! -f "$lastSyncFile" ]; then
  touch $lastSyncFile
fi
# Grab first line of sync record file
lastSyncDate=$(head -n 1 ${lastSyncFile})
# Grab second line of sync record file
lastEditTime=$(sed -n '2p' < ${lastSyncFile})

TODAY=$(date +"%b %d, %Y")
NOW=$(date)
lastTimeWorkFileModified=$(date -r ${DIR}/TODAY.md)

function updateSyncFile {
  lastSyncDate=$TODAY
  lastEditTime=$lastTimeWorkFileModified

  echo "${lastSyncDate}" > "${lastSyncFile}"
  echo "${lastEditTime}" >> "${lastSyncFile}"
}

echo "Attempting sync ${NOW}" >> $logFile

# If work file not modified since last sync, exit
if [ "$lastEditTime" == "$lastTimeWorkFileModified" ]; then
  echo "No need to run sync, file not edited" >> $logFile
  echo "" >> $logFile
  exit 1
fi

# Was not able to set these variables, so update the sync file
if [ -z "$lastSyncDate" ] || [ -z "$lastEditTime" ]; then
  updateSyncFile
fi

echo "Last sync date: ${lastSyncDate}" >> $logFile

archiveFile="${DIR}/ARCHIVE/${TODAY}.md"

# copy text from working file to archive file
cp "${DIR}/TODAY.md" "${archiveFile}"

echo "Archived today's work into ${archiveFile}" >> $logFile

# Sync text from working file to 750words.com
# NODEDIR=$(which node)
NODEDIR="/usr/local/bin/node"
$NODEDIR ${DIR}/uploadText.js
echo "ran ${NODEDIR} ${DIR}/uploadText.js" >> $logFile
# WARNING: this assumes the node script succeeded!
echo "Sync'd today's work to 750words.com" >> $logFile

# If current day is different the last sync date
if [ "$lastSyncDate" != "$TODAY" ]; then
  # clears today's file
  echo "Cleared today's file ${NOW}" >> $logFile
  > "${DIR}/TODAY.md"
fi

# update last sync time/date in file
updateSyncFile

echo "" >> $logFile

