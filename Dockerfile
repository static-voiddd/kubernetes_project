# Start with the CentOS 7 base image
FROM centos:7

# Install Apache HTTP server, curl, and tools for working with zip files
RUN yum install -y httpd curl zip unzip

# Set the working directory to the web server root
WORKDIR /var/www/html/

# Use curl to download the ZIP file, unzip it, and clean up
RUN curl -L -o master.zip https://github.com/andrejewski/hubfs/archive/refs/heads/master.zip && \
    unzip master.zip && \
    cp -rvf hubfs-master/* . && \
    rm -rf hubfs-master master.zip

# Start Apache HTTPD in the foreground to keep the container running
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose port 80 for HTTP access
EXPOSE 80
