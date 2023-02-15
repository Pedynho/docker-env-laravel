FROM php:8.1-fpm-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Postgre PDO
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

# Microsoft SQL Server Prerequisites
RUN apt-get update
RUN apt-get install -y odbcinst1debian2 gnupg2 libodbc1 libonig-dev
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list 
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y --no-install-recommends \
        msodbcsql17 \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen
RUN apt-get update
RUN pecl install sqlsrv pdo_sqlsrv xdebug \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv xdebug

# Setup working directory
WORKDIR /var/www/html

# Installing dependencies and set permissions
COPY ./src .

RUN chown -R www-data:www-data storage

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --ignore-platform-reqs