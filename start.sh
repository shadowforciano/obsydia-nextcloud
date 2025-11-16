#!/bin/bash
set -e

echo "🚀 Starting Nextcloud on Railway..."

# Railway persistent volume mounted at /data
if [ ! -d /data/nextcloud ]; then
    echo "📁 Creating Nextcloud data directory"
    mkdir -p /data/nextcloud
    chown -R www-data:www-data /data/nextcloud
fi

# Ensure data symlink exists
if [ ! -L /var/www/html/data ]; then
    echo "🔗 Linking /var/www/html/data → /data/nextcloud"
    ln -s /data/nextcloud /var/www/html/data
fi

echo "🌐 Launching Apache"
apache2-foreground
