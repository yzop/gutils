FROM ubuntu:latest
WORKDIR /
RUN chmod 777 /
COPY . .
RUN apt-get -qq update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository non-free && \
    apt-get -qq update && \
    apt-get install -y build-essential && \
    apt-get update && apt-get -y upgrade && apt-get install -y wget git curl nano unzip xz-utils && \
    echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \| tee -a /etc/apt/sources.list.d/caddy-fury.list && \
    apt-get update && apt-get install caddy && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && sudo apt-get install -y nodejs npm && apt-get install gcc g++ make parallel
    apt-get install -y gcc g++ make && \
    npm install dayjs --save && \
    npm install pm2 -g && \
    npm install --unsafe-perm=true --allow-root
