FROM ubuntu:trusty
MAINTAINER liang.wei <liang.wei@outlook.com>

RUN apt-get -qq update && \
    apt-get install -q -y wget build-essential python-pip python-m2crypto && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip install shadowsocks

#add chacha20
RUN wget https://github.com/jedisct1/libsodium/releases/download/1.0.8/libsodium-1.0.8.tar.gz && \
    tar xf libsodium-1.0.8.tar.gz && \
    cd libsodium-1.0.8 && \
    ./configure && make -j2 && make install && \
    ldconfig

ADD shadowsocks.json /etc/
ADD start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

EXPOSE 25

#CMD ["sh", "-c", "start.sh"]
ENTRYPOINT ["ssserver","-c","/etc/shadowsocks.json","-d","start"]