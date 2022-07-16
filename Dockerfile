FROM php:7.4-apache
COPY moodle /var/www/html
RUN apt update \
    && apt install -y --no-install-recommends zlib1g-dev libzip-dev libpq-dev libpng-dev libicu-dev libxml2 libxml2-dev supervisor busybox-static cron\
    && apt -y clean \
    && docker-php-ext-install zip pdo pdo_pgsql pgsql gd intl xmlrpc soap opcache \
    && mkdir /var/www/moodledata \
    && chmod 0777 /var/www/moodledata \
    && chmod -R 0755 /var/www/html \
    && echo "* * * * * /usr/local/bin/php /var/www/html/admin/cli/cron.php" | crontab

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]