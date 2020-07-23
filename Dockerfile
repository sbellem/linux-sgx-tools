FROM python:3.8.4-buster

RUN apt-get update && apt-get install -y \
        build-essential \
        autoconf \
        gawk \
        bison

RUN apt-get update && apt-get install -y \
        libprotobuf-c-dev \
        protobuf-c-compiler \
        libcurl4-openssl-dev

RUN apt-get install -y python3-protobuf

ENV SGX_TOOLS_HOME /usr/src/linux-sgx-tools
ENV LD_LIBRARY_PATH $SGX_TOOLS_HOME/Pal/src/host/Linux-SGX/tools/common:$SGX_TOOLS_HOME/Pal/lib/crypto/mbedtls/install/lib

WORKDIR /usr/src/linux-sgx-tools
COPY . .

RUN make SGX=1 -C Pal/lib/ target=$PWD/Pal/src/host/Linux-SGX/.lib/
RUN make -C Pal/src/host/Linux-SGX/tools/

WORKDIR /usr/src/linux-sgx-tools/Pal/src/host/Linux-SGX/tools
