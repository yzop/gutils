FROM ubuntu:20.04
COPY package.json /gdutils/

RUN apt-get -qq update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository multiverse && \
    apt-get -qq update && \
    apt-get install -y build-essential && \
    apt-get update && apt-get -y upgrade && apt-get install -y wget git curl nano unzip xz-utils htop python3 python3-pip ffmpeg pv jq python3-lxml p7zip-full p7zip-rar && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && apt-get install -y nodejs && apt-get install -y gcc g++ make parallel && \
    npm install dayjs --save && \
    npm install pm2 -g && \
    npm install --unsafe-perm=true --allow-root

RUN apt-get -qq update && apt-get -qqy upgrade && \
    apt-get install -y libssl-dev libcurl4-openssl-dev python-dev libc-ares-dev autoconf libtool-bin \
    libcrypto++-dev zlib1g-dev \
    libfreeimage-dev libraw-dev libsodium-dev libsqlite3-dev
      
RUN echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
    | tee -a /etc/apt/sources.list.d/caddy-fury.list && \
    apt update && \
    apt install -y caddy module-assistant
