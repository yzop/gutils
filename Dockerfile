FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
#Upgrade Everything
RUN apt-get -qq update && \
    apt-get -y upgrade && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository multiverse && \
    apt-get -qq update && \
    apt-get install -y build-essential

# Upgrade
RUN apt-get update && apt-get -y upgrade 

#More Libs
RUN apt-get -qq update && apt-get -qqy upgrade && \
    apt-get install -y libssl-dev libcurl4-openssl-dev python-dev libc-ares-dev autoconf libtool-bin \
    libcrypto++-dev zlib1g-dev \
    libfreeimage-dev libraw-dev libsodium-dev libsqlite3-dev \
    libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev libbz2-dev

#Java, NodeJS, Buildtools, Ubuntu Env, Nginx
RUN apt-get install -y ubuntu-desktop unity compiz-plugins-extra ubuntu-restricted-extras wget git curl nano unzip xz-utils htop ffmpeg pv jq p7zip-full p7zip-rar && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && apt-get install -y nodejs && apt-get install -y gcc g++ make cmake parallel openjdk-14-jdk-headless nginx 

 # Php
RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get install -y php8.0 libapache2-mod-php8.0
# Ruby
RUN apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get install -y ruby2.5   
#Clang
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    #Adding Repo
    add-apt-repository -y "deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" && \ 
    # LLVM
    apt-get install -y libllvm-11-ocaml-dev libllvm11 llvm-11 llvm-11-dev llvm-11-doc llvm-11-examples llvm-11-runtime && \
    # Clang and co
    apt-get install -y clang-11 clang-tools-11 clang-11-doc libclang-common-11-dev libclang-11-dev libclang1-11 clang-format-11 python-clang-11 clangd-11 && \
    # libfuzzer
    apt-get install -y libfuzzer-11-dev && \
    # lldb
    apt-get install -y  lldb-11 && \
    # lld (linker)
    apt-get install -y lld-11 && \
    # libc++
    apt-get install -y libc++-11-dev libc++abi-11-dev && \
    # OpenMP
    apt-get install -y libomp-11-dev
# Python3 Latest
RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install -y python3.9 python3.8 python3-pip
# C#
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    apt-get install -y ./packages-microsoft-prod.deb && rm -rf packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 aspnetcore-runtime-5.0
#Caddy
RUN echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
    | tee -a /etc/apt/sources.list.d/caddy-fury.list && \
    apt update && \
    apt install -y caddy module-assistant
