# 750Words Sync
## TODO
- (advertise) Set up alerts for when 750 words is mentioned online (reddit, hn) and pitch this project

configure .env
NAME
PASSWORD
DIRECTORY

/usr/local/bin

## Normal Sync
Run SYNC.sh and leave it open in the background
Edit TODAY.md and save it.
You should see a success message 

- At Midnight rename `TODAY.md` to today's date `March 4, 2020.md` and move it to `Archive/`
- Generate a new file, `TODAY.md`, to be edited in the directory of your choice
- When `TODAY.md` changes (and saved), run index.js to sync to website
  - use entr to watch the file for changes

- Write explanation
- Write setup guide
- Write how it works

## Auto-sync

# watchman

`brew update`
`brew install watchman`



watchman-make -p 'TODAY.md' --run foo.sh

foo.sh is in /bin/sh, might have to use full path

watchman-make -p 'TODAY.md' --run '/Users/reidjs/Projects/750words-api/foo2.sh'

run in background (doesn't work after logout):
[from the project dir]
`nohup watchman-make -p 'TODAY.md' --run '/Users/reidjs/Projects/750words-api/foo2.sh' &`

---


entr
homebrew: `brew install entr`
  - how to install homebrew

or direct install and walk through the entr README

run entr in the background
`ls TODAY.md | entr -n echo 'hiasdf' > text.txt &`

---
