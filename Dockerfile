FROM debian:jessie

MAINTAINER Eshin Kunishima, omochi@luna.miko.im

RUN echo "deb http://ftp.jp.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN apt-get install -y git ruby ruby-dev nodejs nodejs-legacy npm && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN gem install bundler compass
RUN npm -g install bower gulp
