FROM adibpraditya/laravel-dev:1.0

# Create app directory
WORKDIR /var/www

COPY . .

EXPOSE 8080