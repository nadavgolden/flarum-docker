service mysql start

apt -y install expect

# Not required in actual script
MYSQL_ROOT_PASSWORD=1

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password:\"
send \"1\r\"
expect \"Repeat new password:\"
send \"1\r\"
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

apt -y purge expect

mysql --user=root --password=1 -e "CREATE DATABASE flarumdb; CREATE USER 'flarumuser'@'localhost' IDENTIFIED BY '12345678'; GRANT ALL PRIVILEGES ON flarumdb.* To 'flarumuser'@'localhost';"

