# 4. Build PHP/Apache stage
FROM php:7.4.30-apache

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 5. Copy over index.php
COPY index.php /var/www/html

# 6. Copy over PHP package install files from Composer stage to PHP/Apache stage
#COPY --from=builder /app/vendor /var/www/html/vendor

# 7. Start Apache service
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
