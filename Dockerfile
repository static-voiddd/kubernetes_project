# Start with the CentOS base image
FROM centos

# Install Apache HTTP server, and tools for working with zip files
RUN yum install -y httpd zip unzip

# Add the HTML template zip file from the new URL
ADD https://github.com/andrejewski/hubfs/archive/refs/heads/master.zip /var/www/html/

# Set the working directory to the web server root
WORKDIR /var/www/html/

# Unzip the downloaded file, move the contents, and clean up
RUN unzip master.zip && \
    cp -rvf hubfs-master/* . && \
    rm -rf hubfs-master master.zip

# Start Apache HTTPD in the foreground to keep the container running
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose port 80 for HTTP access
EXPOSE 80
