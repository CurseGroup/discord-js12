FROM ubuntu:18.04

MAINTAINER Arnaud LIER, <zeprofdecoding@gmail.com>

RUN apt update \
    && apt upgrade -y \
    && apt autoremove -y \
    && apt autoclean \
    && apt -y install curl software-properties-common locales git cmake \
    && useradd -d /home/container -m container

    # Ensure UTF-8
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
ENV TZ=Europe/Paris

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt update \
    && apt -y upgrade \
    && apt -y install nodejs node-gyp \
    && npm install discord.js node-opus opusscript \
    && npm install sqlite3 --build-from-source
    
RUN apt -y install ffmpeg

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
