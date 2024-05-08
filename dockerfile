FROM php:7.4.30-cli

# Set the working directory in the container

WORKDIR /var/www/html

# Installl dependencies )

RUN apt update \
        && apt install -y libpng-dev zlib1g-dev libxml2-dev libzip-dev libonig-dev zip curl unzip \
        && docker-php-ext-configure gd \
        && docker-php-ext-install pdo pdo_mysql sockets mysqli zip -j$(nproc) gd \
        && docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the rest of the application code into the container
COPY . /var/www/html
RUN mv .env.sample .env

# Expose port 8000 for the Laravel development server
EXPOSE 8000

# Define the command to start the Laravel development server
ENTRYPOINT [ "sh", "serve.sh" ]