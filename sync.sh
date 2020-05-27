#!/bin/bash

# The directory of the project code and archive
DIR="${1}"
SECOND="${2}"
# The directory of TODAY.md, if left blank should assign to project code directory (untested)
# Assign READDIR (where our TODAY and ARCHIVE files go) to either the 2nd param passed in, or to default to the first param
READDIR=${SECOND:-$DIR}

lastSyncFile="${DIR}/.last-sync"
logFile="${DIR}/.log"

if [ ! -f "$lastSyncFile" ]; then
  touch $lastSyncFile
fi
# Grab first line of sync record file
lastSyncDate=$(head -n 1 "${lastSyncFile}")
# Grab second line of sync record file
lastEditTime=$(sed -n '2p' < "${lastSyncFile}")

TODAY=$(date +"%b %d, %Y")
NOW=$(date)
lastTimeWorkFileModified=$(date -r "${READDIR}/TODAY.md")

function updateSyncFile {
  lastSyncDate=$TODAY
  lastEditTime=$lastTimeWorkFileModified

  echo "${lastSyncDate}" > "${lastSyncFile}"
  echo "${lastEditTime}" >> "${lastSyncFile}"
}

echo "Attempting sync '${NOW}'" >> "${logFile}"

# If work file not modified since last sync, exit
if [ "$lastEditTime" == "$lastTimeWorkFileModified" ]; then
  echo "No need to run sync, file not edited" >> "${logFile}"
  echo "" >> "${logFile}"
  exit 1
fi

# Was not able to set these variables, so update the sync file
if [ -z "$lastSyncDate" ] || [ -z "$lastEditTime" ]; then
  updateSyncFile
fi

echo "Last sync date: ${lastSyncDate}" >> "${logFile}"


# copy text from working file to archive file

mkdir -p "${READDIR}/750WORDS_ARCHIVE" && cp "${READDIR}/TODAY.md" "${READDIR}/750WORDS_ARCHIVE/${TODAY}.md"

echo "Archived today's work to ${READDIR}" >> "${logFile}"

# Sync text from working file to 750words.com
# NODEDIR=$(which node)
NODEDIR="/usr/local/bin/node"
$NODEDIR "${DIR}/uploadText.js" "${READDIR}"
echo "ran '${NODEDIR}' '${DIR}/uploadText.js'" >> "${logFile}"
# WARNING: this assumes the node script succeeded!
echo "Sync'd today's work to 750words.com" >> "${logFile}"

# If current day is different the last sync date
if [ "$lastSyncDate" != "$TODAY" ]; then
  # clears today's file
  echo "Cleared today's file '${NOW}'" >> "${logFile}"
  > "${READDIR}/TODAY.md"
fi

# update last sync time/date in file
updateSyncFile

echo "" >> "${logFile}"

