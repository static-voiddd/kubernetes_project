# Start with the Ubuntu base image
FROM ubuntu:latest

# Update package lists and install Apache, curl, and zip/unzip tools
RUN apt-get update && apt-get install -y apache2 curl zip unzip

# Set the working directory to the web server root
WORKDIR /var/www/html/

# Use curl to download the ZIP file, unzip it, and clean up
RUN curl -L -o sample.zip https://codeload.github.com/jquery/jquery/zip/refs/heads/main && \
    unzip sample.zip && \
    cp -rvf jquery-main/* . && \
    rm -rf jquery-main sample.zip

# Start Apache HTTPD in the foreground to keep the container running
CMD ["apachectl", "-D", "FOREGROUND"]

# Expose port 80 for HTTP access
EXPOSE 80 