# Building
- You can easily edit the script `mysql_install.sh` to change:
1. mysql root password
2. Flarum's username and password on mysql server

- Change nginx config for flarum by editting `flarum.conf`
    
# Pulling

`sudo docker run -d -p 80:80 nadi106/flarum:0.1.0-beta.8`

## Default configuration

### MySQL
- Root password: `12345678`
- Databse: `flarumdb`
- Username for Flarum: `flarumuser`
- Password for user: `12345678`

## How to setup for dummies
After running the container, go to `http://localhost` on your browser and enter:
- Forum Title: (of your choosing)
    
- MySQL Database: flarumdb
- MySQL Username: flarumuser
- MySQL Password: 12345678
- Table Prefix: (leave empty)

You can choose your own admin username and password in the next section.


