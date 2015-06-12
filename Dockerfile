FROM debian:jessie

MAINTAINER Eshin Kunishima, omochi@luna.miko.im

# Update all packages
RUN cat /dev/null > /etc/apt/sources.list && \
    echo "deb http://ftp.jp.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://ftp.jp.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install additional packages
RUN apt-get update && \
    apt-get install -y git && \
    apt-get build-dep -y nodejs ruby openjdk-7-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install latest Ruby
RUN cd /tmp && \
    curl -O https://ftp.ruby-lang.org/pub/ruby/stable-snapshot.tar.gz && \
    tar xvzf stable-snapshot.tar.gz && \
    cd stable-snapshot && \
    ./configure && make -j 2 && make install && \
    cd /tmp && \
    rm -fr *

# RubyGems
RUN gem install bundler compass

# Install latest Node.js
RUN cd /tmp && \
    curl -O http://nodejs.org/dist/node-latest.tar.gz && \
    tar xvzf node-latest.tar.gz && \
    cd node-v* && \
    ./configure && make -j 2 && make install && \
    cd /tmp && \
    rm -fr * && \
    npm install -g npm

# npm
RUN npm -g install bower gulp
