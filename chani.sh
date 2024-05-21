# DATABASE Chani

# 13 - step 1

# Set DNS resolver
echo 'nameserver 10.72.3.1' > /etc/resolv.conf

# Update package list and install MariaDB server
apt-get update
apt-get install -y mariadb-server

# Start MariaDB service
service mysql start

# Update MariaDB configuration to allow remote connections
cat <<EOF > /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
bind-address = 0.0.0.0
EOF

# Restart MariaDB service to apply configuration changes
service mysql restart

# Wait for the server to restart
sleep 5

# MySQL commands to set up user and database
echo "
DROP USER IF EXISTS 'kelompokIT17'@'%';
DROP USER IF EXISTS 'kelompokIT17'@'localhost';

DROP DATABASE IF EXISTS dbkelompokIT17;
DROP DATABASE IF EXISTS DADDYS_HOME;
DROP DATABASE IF EXISTS GOJO_IS_BACK;
DROP DATABASE IF EXISTS NAH_ID_WIN;

CREATE USER 'kelompokIT17'@'%' IDENTIFIED BY 'passwordIT17';
CREATE USER 'kelompokIT17'@'localhost' IDENTIFIED BY 'passwordIT17';

CREATE DATABASE dbkelompokIT17;
CREATE DATABASE DADDYS_HOME;
CREATE DATABASE GOJO_IS_BACK;
CREATE DATABASE NAH_ID_WIN;

GRANT ALL PRIVILEGES ON *.* TO 'kelompokIT17'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokIT17'@'localhost';

FLUSH PRIVILEGES;
" | mysql -u root -p

