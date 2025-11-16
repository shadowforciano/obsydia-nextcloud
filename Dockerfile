FROM nextcloud:29-apache

# Force Railway to pull the latest Nextcloud image
RUN echo "force-rebuild-$(date +%s)"

# Install cron for background jobs
RUN apt-get update && apt-get install -y --no-install-recommends cron \
    && rm -rf /var/lib/apt/lists/*

# Enable cron
RUN echo "*/5 * * * * www-data php -f /var/www/html/cron.php" > /etc/cron.d/nextcloud-cron
RUN chmod 0644 /etc/cron.d/nextcloud-cron
RUN crontab /etc/cron.d/nextcloud-cron

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Additional rebuild marker (forces Railway to avoid cache)
RUN echo "rebuild-$(date +%s)"

CMD ["/start.sh"]
