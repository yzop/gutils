FROM nginx:latest
WORKDIR /
RUN chmod 777 /

COPY . .
COPY default.conf /etc/nginx/conf.d/
RUN apt-get -qq update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository non-free && \
    apt-get -qq update && \
    apt-get install -y build-essential && \
    apt-get update && apt-get -y upgrade && apt-get install -y wget git curl nano unzip xz-utils && \
    apt-get install -y gcc g++ make && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install dayjs --save && \
    npm install pm2 -g && \
    npm install --unsafe-perm=true --allow-root && \
    chmod 777 /etc/nginx/conf.d/default.conf
CMD bash start.sh && pm2 start server.js && sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;' && echo "Bot Has been Sucessfully Started"
