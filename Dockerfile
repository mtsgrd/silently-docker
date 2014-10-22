############################################################
# Dockerfile to build Python WSGI Application Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Mattias Granlund (mtsgrd@gmail.com)

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y git curl build-essential default-jre

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip redis-server

# Install Ruby + SASS
RUN apt-get install -y ruby-full rubygems-integration
RUN gem install -y sass

# Pull silently-backend
RUN mkdir silently-backend && \
    cd silently-backend && \
    git init && \
    git pull https://dabbe59998dc3a3915e7b7cfcf47716add0b172f:x-oauth-basic@github.com/mtsgrd/silently-backend.git

# Get pip to download and install requirements:
RUN pip install -r silently-backend/requirements.txt

# Pull silently-client
RUN mkdir silently-client && \
    cd silently-client && \
    git init && \
    git pull https://dabbe59998dc3a3915e7b7cfcf47716add0b172f:x-oauth-basic@github.com/mtsgrd/silently-client.git && \
    git submodule init && \
    git submodule update

# Link public folder across repositories.
RUN ln -s /silently-client/public /silently-backend/silently/frontend/static

# Compile client code.
RUN cd silently-client && mkdir public/css && ./build.sh -v -s -m script -f dev

# Expose ports
EXPOSE 5000

# Set the default directory where CMD will execute
WORKDIR silently-backend

# Set the default command to execute
# when creating a new container
# i.e. using CherryPy to serve the application
CMD redis-server --daemonize yes && python server.py
