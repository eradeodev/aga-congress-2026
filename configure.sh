#!/bin/bash

# Command to run wp-cli in docker
WP_CLI="docker exec -it aga-congress-2026-wp-cli-1 wp"

# Install core site with default credentials
$WP_CLI core install --url=http://localhost --title="U.S. Go Congress" --admin_user=admin --admin_password=password --admin_email=admin@admin.example

# Import our pages
$WP_CLI plugin install wordpress-importer --activate
$WP_CLI import /import_data/base_pages.xml --authors=create

# Install kadence theme and plugins
$WP_CLI theme install kadence --activate
$WP_CLI plugin install stackable-ultimate-gutenberg-blocks --activate
$WP_CLI plugin install wp-super-cache --activate

# Make front page show a static page instead of blog posts, and set it to our home page
$WP_CLI option update show_on_front 'page'
$WP_CLI option update page_on_front 5
