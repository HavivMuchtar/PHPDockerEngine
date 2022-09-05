# 1. Build PHP/Apache stage
FROM php:7.4.30-apache

# 2. Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 3. Copy over index.php
COPY index.php /var/www/html

# 4. Start Apache service
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
