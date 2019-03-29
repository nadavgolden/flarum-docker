
MYSQL_ROOT_PASSWORD=12345678

FLARUM_DB_NAME=flarumdb
FLARUM_USERNAME=flarumuser
FLARUM_PASSWORD=12345678

service mysql start

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Repeat new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $FLARUM_DB_NAME; CREATE USER '$FLARUM_USERNAME'@'localhost' IDENTIFIED BY '$FLARUM_PASSWORD'; GRANT ALL PRIVILEGES ON $FLARUM_DB_NAME.* To '$FLARUM_USERNAME'@'localhost';"

