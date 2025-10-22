#!/bin/bash

# Command to run wp-cli in docker
CLI_CONTAINER="aga-congress-2026-wp-cli-1"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="password"
ADMIN_EMAIL="admin@admin.example"

BASE_CMD="docker exec -it $CLI_CONTAINER "

# Install core site with default credentials
$BASE_CMD wp core install --url=http://localhost --title="U.S. Go Congress" --admin_user="$ADMIN_USERNAME" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL"

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
