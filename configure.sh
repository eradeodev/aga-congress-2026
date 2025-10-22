#!/bin/bash

# Command to run wp-cli in docker
CLI_CONTAINER="aga-congress-2026-wp-cli-1"
ADMIN_USERNAME="admin"
ADMIN_EMAIL="webmaster@gocongress.org"
GOCONGRESS_URL="https://gc2026.gocongress.org"
# prompt for admin password
read -s -p "Admin password: " ADMIN_PASSWORD
echo

BASE_CMD="docker exec -it $CLI_CONTAINER "

# Install core site with default credentials
# Use non-tty docker exec (-i, not -t) and pass the password via stdin to the container
docker exec -i "$CLI_CONTAINER" bash -c \
  'read -r PASS; wp core install --url="$3" --title="U.S. Go Congress" --admin_user="$1" --admin_password="$PASS" --admin_email="$2"' \
  -- "$ADMIN_USERNAME" "$ADMIN_EMAIL" "$GOCONGRESS_URL" <<EOF
$ADMIN_PASSWORD
EOF
unset ADMIN_PASSWORD

# Import our pages
$BASE_CMD wp plugin install wordpress-importer --activate
$BASE_CMD cp /import_data/base_pages.xml /var/www/html/base_pages.xml
$BASE_CMD wp import /var/www/html/base_pages.xml --authors=create

# Install kadence theme and plugins
$BASE_CMD wp theme install kadence --activate
$BASE_CMD wp plugin install stackable-ultimate-gutenberg-blocks --activate
$BASE_CMD wp plugin install wp-super-cache --activate

# Make front page show a static page instead of blog posts, and set it to our home page
$BASE_CMD wp option update show_on_front 'page'
$BASE_CMD wp option update page_on_front 5
