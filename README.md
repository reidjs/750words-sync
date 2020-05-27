# 750Words Sync
Automate archiving and uploading text to 750words.com. 

## SETUP
### 1. Download
1. Open a terminal and navigate (cd) to where you'd like to put it

2. Clone this project

`git clone https://github.com/reidjs/750words-sync.git`

3. Change directory to this project

`cd 750words-sync`

4. Install npm packages

`npm i`

5. Enable the sync script

*WARNING: if `which node` doesn't return `/usr/local/bin/node` this script will not work!*

`chmod +x sync.sh`

### 2. (OPTIONAL) Set up auto-sync

1. From the project directory in your terminal, copy `sync.sh` to your local user dir

`cp sync.sh /usr/local/bin/sync.sh`

2. Open your crontab

`crontab -e`

3. Add this line to your crontab: 

*if it opened in vi on mac, press `cmd+v` to paste*

`* * * * * /usr/local/bin/sync.sh /path/to/750words-sync >> /path/to/optional/output/file/out.md`

Write and save the crontab.

*If in vi, press `esc` then type `:wq!`*

### 3. Configure the dotfile (.env)
1. Open EMPTY.env and set NAME and PASSWORD to your 750words.com login:

```
NAME=bobsmith@gmail.com
PASSWORD=hunter2
```

2. Rename the file (`EMPTY.env`) to `.env`

### 4. Write!

Open `TODAY.md` with your favorite text editor and start writing! Your previous day's writings will save to the `ARCHIVE/` folder named with the date they were written. `TODAY.md` will clear every day and auto archive and sync to 750words.com once per minute if edited.


## TODO
- Advertise
  - Set up alerts for when 750 words is mentioned online (reddit, hn) and pitch this project
  - Mention on 750words.com website

- Write up
  - tech used
  - how it works
