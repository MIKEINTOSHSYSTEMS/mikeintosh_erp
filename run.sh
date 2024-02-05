#!/bin/bash

DESTINATION=$1
ODOO_PORT=$2
PGADMIN_PORT=$3
DB_NAME="merqconsultancyhq"

git clone --depth=1 https://github.com/merqconsultancyTEMS/mikeintosh_erp.git $DESTINATION
rm -rf $DESTINATION/.git
chmod -R 777 $DESTINATION

if ! grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then 
  echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; 
fi
sudo sysctl -p

sed -i 's/8079/'$ODOO_PORT'/g' $DESTINATION/docker-compose.yml
sed -i 's/5454:80/'$PGADMIN_PORT':80/g' $DESTINATION/docker-compose.yml

echo "DB_NAME=$DB_NAME" >> $DESTINATION/.env

cd $DESTINATION && docker-compose up -d

echo "Odoo started @ http://localhost:$ODOO_PORT | Default Admin User: admin@merqconsultancy.com | Default Admin Password: merqhqadmin | pgAdmin started @ http://localhost:$PGADMIN_PORT"
