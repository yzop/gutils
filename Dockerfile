FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
LABEL maintainer="YZOP"

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
                       uidmap
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
                       dirmngr
                       
#Jellyfin
RUN apt-get install -y apt-transport-https && \
    wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | apt-key add - && \
    echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | tee /etc/apt/sources.list.d/jellyfin.list && \
    apt-get update && \
    apt install -y jellyfin \
                   i965-va-driver \
                   intel-media-va-driver-non-free \
                   libfontconfig1 \
                   libfreetype6 \
                   libssl1.1 \
                   mesa-va-drivers

#Googler
RUN wget -q https://github.com/jarun/googler/releases/download/v4.3.1/googler_4.3.1-1_ubuntu20.04.amd64.deb && \
    apt-get install -y ./googler_4.3.1-1_ubuntu20.04.amd64.deb && rm -rf googler_4.3.1-1_ubuntu20.04.amd64.deb

#Browsh
RUN wget -q https://github.com/browsh-org/browsh/releases/download/v1.6.4/browsh_1.6.4_linux_amd64.deb && \
    apt-get install -y ./browsh_1.6.4_linux_amd64.deb && rm -rf browsh_1.6.4_linux_amd64.deb

#Ubuntu Desktop
RUN apt-get install -y ubuntu-desktop \
                       unity \
                       compiz-plugins-extra \
                       ubuntu-restricted-extras
#Node JS
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash && \
    #Node JS and NPM
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    #Yarn
    apt-get install -y yarn
 
#PostgreSQL
RUN apt-get -y install postgresql \
               postgresql-contrib
#MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-unstable.list && \
    apt-get update && \
    apt-get install -y mongodb-org=4.4.3 \
                       mongodb-org-server=4.4.3 \
                       mongodb-org-shell=4.4.3 \
                       mongodb-org-mongos=4.4.3 \
                       mongodb-org-tools=4.4.3 
    
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

# Python3 Latest
RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install -y python3.9 \
                   python3.8 \
                   python3-pip

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
                       neovim \
                       yq
                       
#Kakoune
RUN apt install -t libncursesw5-dev pkg-config && \
    git clone https://github.com/mawww/kakoune.git && cd kakoune/src && \
    make && \
    PREFIX=$HOME/.local make install

#SNAPD
RUN apt-get install snapd

# emacs
RUN add-apt-repository -y ppa:kelleyk/emacs && \
    apt-get update && \
    apt-get install -y emacs27

#Lazy Docker
RUN curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
#Caddy
RUN echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
    | tee -a /etc/apt/sources.list.d/caddy-fury.list && \
    apt update && \
    apt install -y caddy \
                   module-assistant
