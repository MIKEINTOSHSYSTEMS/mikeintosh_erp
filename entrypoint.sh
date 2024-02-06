#!/bin/bash

set -e

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='merqconsultancy'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='merqhqadmin'}}}

# install python packages
pip3 install pip --upgrade
pip3 install -r /etc/odoo/requirements.txt

# Add the default Odoo admin user and password
ODOO_ADMIN_USER="admin@merqconsultancy.org"
ODOO_ADMIN_PASSWORD="merqhqadmin"
echo "Creating default Odoo admin user..."
echo "from odoo import api, models
User = models.execute_kw(db, uid, password, 'res.users', 'create', [{
    'login': '${ODOO_ADMIN_USER}',
    'name': 'Admin User',
    'password': '${ODOO_ADMIN_PASSWORD}',
}])" > /docker-entrypoint-init/create_default_admin_user.py

# sed -i 's|raise werkzeug.exceptions.BadRequest(msg)|self.jsonrequest = {}|g' /usr/lib/python3/dist-packages/odoo/http.py

DB_ARGS=()
function check_config() {
    param="$1"
    value="$2"
    if grep -q -E "^\s*\b${param}\b\s*=" "$ODOO_RC" ; then       
        value=$(grep -E "^\s*\b${param}\b\s*=" "$ODOO_RC" |cut -d " " -f3|sed 's/["\n\r]//g')
    fi;
    DB_ARGS+=("--${param}")
    DB_ARGS+=("${value}")
}
check_config "db_host" "$HOST"
check_config "db_port" "$PORT"
check_config "db_user" "$USER"
check_config "db_password" "$PASSWORD"

case "$1" in
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            exec odoo "$@"
        else
            wait-for-psql.py ${DB_ARGS[@]} --timeout=30
            exec odoo "$@" "${DB_ARGS[@]}"
        fi
        ;;
    -*)
        wait-for-psql.py ${DB_ARGS[@]} --timeout=30
        exec odoo "$@" "${DB_ARGS[@]}"
        ;;
    *)
        exec "$@"
esac

exit 1
