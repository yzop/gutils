FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
LABEL maintainer="YZOP"

ENV PY38VER "3.8.10"
ENV PY39VER "3.9.5"
ENV LD_LIBRARY_PATH "/usr/local/lib"
#Upgrade Everything
RUN apt-get -qq update && \
    apt-get -y upgrade && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository multiverse && \
    apt-add-repository universe && \
    apt-get -qq update && \
    apt-get install -y build-essential

# Upgrade
RUN apt-get update && apt-get -qqy upgrade 

#More Libs
RUN apt-get install -y libssl-dev \
                       libcurl4-openssl-dev \
                       python-dev \
                       libc-ares-dev \
                       autoconf \
                       libtool-bin \
                       libcrypto++-dev \
                       zlib1g-dev \
                       libfreeimage-dev \
                       libraw-dev \
                       libsodium-dev \
                       libsqlite3-dev \
                       libncurses-dev \
                       libncursesw5-dev \
                       libncurses5-dev \
                       libgdbm-dev \
                       libnss3-dev \
                       libreadline-dev \
                       libffi-dev \
                       libbz2-dev \
                       gcc \
                       g++ \
                       make \
                       cmake \
                       uidmap \
                       m4
                       
#Utils 
RUN apt-get install -y wget \
                       git \
                       curl \
                       nano \
                       unzip \
                       zip \
                       xz-utils \
                       htop \
                       ffmpeg \
                       pv \
                       jq \
                       p7zip-full \
                       p7zip-rar \
                       parallel \
                       neofetch \
                       screen \
                       glances \
                       ranger \
                       calcurse \
                       chkrootkit \
                       ack \
                       silversearcher-ag \
                       thefuck \
                       mtr \
                       pydf \
                       nnn \
                       gnupg \
                       ca-certificates \
                       numactl \
                       procps \
                       dirmngr \
                       pkg-config \
                       dumb-init \
                       locales \
                       man \
                       procps \
                       ssh \
                       vim \
                       fuse \
                       sudo

#Locales
ENV LANG=en_US.UTF-8
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && \ 
    locale-gen

# Jellyfin
# RUN apt-get install -y apt-transport-https && \
#    wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | apt-key add - && \
#    echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | tee /etc/apt/sources.list.d/jellyfin.list && \
#    apt-get update && \
#    apt install -y jellyfin \
#                   i965-va-driver \
#                   intel-media-va-driver-non-free \
#                   libfontconfig1 \
#                   libfreetype6 \
#                   libssl1.1 \
#                   mesa-va-drivers

#Googler
RUN wget -q https://github.com/jarun/googler/releases/download/v4.3.2/googler_4.3.2-1_ubuntu20.04.amd64.deb && \
    apt-get install -y ./googler_4.3.2-1_ubuntu20.04.amd64.deb && rm -rf googler_4.3.2-1_ubuntu20.04.amd64.deb

#Browsh
RUN wget -q https://github.com/browsh-org/browsh/releases/download/v1.6.4/browsh_1.6.4_linux_amd64.deb && \
    apt-get install -y ./browsh_1.6.4_linux_amd64.deb && rm -rf browsh_1.6.4_linux_amd64.deb

# Ubuntu Desktop
# RUN apt-get install -y ubuntu-desktop \
#                       unity \
#                        compiz-plugins-extra \
#                       ubuntu-restricted-extras
#Node JS
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash && \
    #Node JS and NPM
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    #Yarn
    apt-get install -y yarn
 
#PostgreSQL
RUN apt-get -y install postgresql \
               postgresql-contrib
#MongoDir
RUN mkdir -p /data/db && \
    mkdir -p /log/mongo && \
    chmod 777 /data/db && \
    chmod 777 /log/mongo
#Nginx
RUN apt-get install -y nginx

#Java
RUN apt-get install -y openjdk-14-jdk-headless

# Php
RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get install -y php8.0 \
                       libapache2-mod-php8.0
                     
# Ruby
RUN apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get install -y ruby2.5   

#Clang
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    #Adding Repo
    add-apt-repository -y "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" && \ 
    # LLVM
    apt-get install -y libllvm-11-ocaml-dev \
                       libllvm11 \
                       llvm-11 \
                       llvm-11-dev \
                       llvm-11-doc \
                       llvm-11-examples \
                       llvm-11-runtime && \
    # Clang and co
    apt-get install -y clang-11 \
                       clang-tools-11 \
                       clang-11-doc \
                       libclang-common-11-dev \
                       libclang-11-dev \
                       libclang1-11 \
                       clang-format-11 \
                       clangd-11 && \
    # libfuzzer
    apt-get install -y libfuzzer-11-dev && \
    # lldb
    apt-get install -y  lldb-11 && \
    # lld (linker)
    apt-get install -y lld-11 && \
    # libc++
    apt-get install -y libc++-11-dev \
                       libc++abi-11-dev && \
    # OpenMP
    apt-get install -y libomp-11-dev

# # Python3 Latest
# RUN add-apt-repository -y ppa:deadsnakes/ppa && \
#     apt install -y python3.9 python3.9-dev \
#                    python3.8 python3.8-dev \
#                    python3-pip

# Compile Python 3.8
RUN wget https://www.python.org/ftp/python/$PY38VER/Python-$PY38VER.tar.xz && \
    tar -xf Python-$PY38VER.tar.xz && rm -rf Python-$PY38VER.tar.xz && cd Python-$PY38VER && \
    ./configure --enable-optimizations --enable-shared && make -j$(nproc) && \
    make altinstall && rm -rf Python-$PY38VER

# Compile Python 3.8
RUN wget https://www.python.org/ftp/python/$PY39VER/Python-$PY39VER.tar.xz && \
    tar -xf Python-$PY39VER.tar.xz && rm -rf Python-$PY39VER.tar.xz && cd Python-$PY39VER && \
    ./configure --enable-optimizations --enable-shared && make -j$(nproc) && \
    make altinstall && rm -rf Python-$PY39VER

# C#
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    apt-get install -y ./packages-microsoft-prod.deb && rm -rf packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 \
                       aspnetcore-runtime-5.0

#Utils2
RUN apt-get install -y bcal \
                       neovim                       

#Caddy
RUN echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
    | tee -a /etc/apt/sources.list.d/caddy-fury.list && \
    apt update && \
    apt install -y caddy \
                   module-assistant
