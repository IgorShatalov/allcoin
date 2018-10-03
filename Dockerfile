FROM ubuntu:16.04

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
		curl \
         git \
         automake \
         build-essential \
         libtool \
         autotools-dev \
         autoconf \
         pkg-config \
         libssl-dev \ 
         libboost-all-dev \
         libevent-dev \
         bsdmainutils \
         vim \
         software-properties-common && \
         rm -rf /var/lib/apt/lists/* && apt-get clean

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
          libdb4.8-dev \
          libdb4.8++-dev \
          libminiupnpc-dev && \
          rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /allcoin

COPY . .

RUN ./contrib/build-docker.sh

VOLUME ["/root/.allcoin"]

EXPOSE 22331

CMD exec allcoind && tail -f /root/.allcoin/debug.log
 
