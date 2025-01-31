#!/bin/bash

set -e

# Check if database exists and web_enterprise is not installed
check_enterprise_installed() {
  PGHOST=db PGUSER=odoo PGPASSWORD="$(cat /run/secrets/postgresql_password)" psql -d "$1" -tAc "SELECT 1 FROM ir_module_module WHERE name='web_enterprise' AND state='installed'" | grep -q 1
}

install_enterprise_if_needed() {
  local DB_NAME="$1"
  if ! check_enterprise_installed "$DB_NAME"; then
    echo "Installing web_enterprise in database: $DB_NAME"
    odoo --config=/etc/odoo/odoo.conf -d "$DB_NAME" -i web_enterprise --stop-after-init
  fi
}

# Install for default database (postgres)
install_enterprise_if_needed "postgres"

# Start Odoo normally
exec "$@"