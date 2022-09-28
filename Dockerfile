FROM php:8.1.0-fpm as php
# FROM php:8.1-cli
# Set working directory
COPY ./ /var/www/html

# RUN apt-get update -y
# RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_mysql bcmath
RUN docker-php-ext-enable pdo_mysql

WORKDIR /var/www/html
COPY . .

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

ENTRYPOINT [ "./entrypoint.sh" ]

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]