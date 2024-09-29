# Start with the Ubuntu base image
FROM ubuntu:latest

# Update package lists and install Apache, curl, and zip/unzip tools
RUN apt-get update && apt-get install -y apache2 curl zip unzip

# Set the working directory to the web server root
WORKDIR /var/www/html/

# Use curl to download the ZIP file, unzip it, and clean up
RUN curl -L -o master.zip https://github.com/andrejewski/hubfs/archive/refs/heads/master.zip && \
    unzip master.zip && \
    cp -rvf hubfs-master/* . && \
    rm -rf hubfs-master master.zip

# Start Apache HTTPD in the foreground to keep the container running
CMD ["apachectl", "-D", "FOREGROUND"]

# Expose port 80 for HTTP access
EXPOSE 80
