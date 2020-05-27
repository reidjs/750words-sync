# 750Words Sync
Automate archiving and uploading text to 750words.com. 


## SETUP
### 1. Download
1. Open a terminal

2. Clone this project

`git clone https://github.com/reidjs/750words-sync.git`

3. Change directory (cd) to this project

`cd 750words-sync`

4. Enable the sync script

`chmod +x sync.sh`

5. (OPTIONAL) set the sync script to run automatically every minute

`crontab -e`

Add this line to your crontab: (if it opened in vim, press `i` then paste with CTRL+V)

`* * * * * (cd /Users/reidjs/Projects/750words-sync/; ./sync.sh)`

Write and save (press `esc` then `:wq!` if in vim)

### Configure .env
1. Open EMPTY.env and set NAME and PASSWORD to your 750words.com login:
NAME
PASSWORD


## TODO
- (advertise) Set up alerts for when 750 words is mentioned online (reddit, hn) and pitch this project


/usr/local/bin

## Normal Sync

- Write explanation
- Write setup guide
- Write how it works
