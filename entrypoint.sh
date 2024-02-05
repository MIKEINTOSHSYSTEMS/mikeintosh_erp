#!/bin/bash

set -e

# Install Python packages
pip3 install pip --upgrade
pip3 install --no-cache-dir -r /etc/odoo/requirements.txt

# Set environment variables
export ODOO_DATABASE_HOST=db
export ODOO_DATABASE_PORT_NUMBER=${ODOO_DATABASE_PORT_NUMBER}
export ODOO_DATABASE_NAME=${DB_NAME}
export ODOO_DATABASE_USER=${DB_USER}
export ODOO_DATABASE_PASSWORD=${DB_PASSWORD}
export ODOO_DATA_TO_PERSIST=${ODOO_ADDONS_DIR} ${ODOO_CONF_DIR} ${ODOO_DATA_DIR}
export ODOO_SKIP_BOOTSTRAP=no
export ODOO_SKIP_MODULES_UPDATE=no
export ODOO_LOAD_DEMO_DATA=no
export ODOO_EMAIL=${ODOO_ADMIN_EMAIL}
export ODOO_PASSWORD=${ODOO_ADMIN_PASSWORD}

# Start Odoo
case "$1" in
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            exec odoo "$@"
        else
            wait-for-psql.py --timeout=30 ${DB_ARGS[@]}
            exec odoo "$@" "${DB_ARGS[@]}"
        fi
        ;;
    -*)
        wait-for-psql.py --timeout=30 ${DB_ARGS[@]}
        exec odoo "$@" "${DB_ARGS[@]}"
        ;;
    *)
        exec "$@"
esac

exit 1
