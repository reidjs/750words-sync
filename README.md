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

`* * * * * /usr/local/bin/sync.sh /path/to/project/directory/750words-sync "/path/to/directory/with/file/named/TODAY.md/foo/etc" >> /path/to/log/file/out.md`

Write and save the crontab.

*If in vi, press `esc` then type `:wq!`*

### 3. Configure the dotfile (.env)
1. Open EMPTY.env and set NAME and PASSWORD to your 750words.com login:

```
NAME=bobsmith@gmail.com
PASSWORD=hunter2
```

2. Rename the file (`EMPTY.env`) to `.env`

_Now let's make sure everything's working_

3. Create a file named 'TODAY.md'

`touch TODAY.md`

4. Add some text to `TODAY.md`

`echo hello > TODAY.md`

5. Run the sync script in the current directory with 

`./sync.sh .`

Log in to 750words.com and ensure "hello" shows up on today's page.

### 4. Write!

Open `TODAY.md` with your favorite text editor and start writing! Your writings will automatically save to the local `750WORDS_ARCHIVE/` folder and sync their text to 750words.com.

If you set up the optional auto-sync script, every day at midnight:

1. All the text in `TODAY.md` will copy to into a file with today's date in `750WORDS_ARCHIVE/`. For example if today is January 3rd, 2021 it will create a file named `January 3, 2021.md`.
2. All the text in `TODAY.md` will sync to 750words.com.
3. `TODAY.md` will clear itself out

## TODO
- Advertise
  - Set up alerts for when 750 words is mentioned online (reddit, hn) and pitch this project
  - Mention on 750words.com website

- Write up
  - tech used
  - how it works
