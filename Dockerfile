FROM ubuntu:latest

MAINTAINER justin@kohactive.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common python-software-properties
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:mc3man/trusty-media
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ffmpeg
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libpcre3-dev libpcre++-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssl libssl-dev

ADD ./src /root/src

WORKDIR /root/src

RUN tar -zxvf nginx-1.8.0.tar.gz
RUN tar -zxvf nginx-rtmp-module-1.1.7.tar.gz

WORKDIR /root/src/nginx-1.8.0

RUN ./configure --with-http_mp4_module --with-http_flv_module --add-module=../nginx-rtmp-module-1.1.7
RUN make && make install

RUN mkdir -p /var/log/nginx

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libcurl4-openssl-dev libxml2-dev mime-support automake libtool

ADD ./src /root/src

WORKDIR /root/src


ADD ./config/nginx.conf /etc/conf/nginx.conf

ADD ./scripts/start.sh /root/start.sh
RUN chmod +x /root/start.sh


EXPOSE 80
EXPOSE 443
EXPOSE 1935
EXPOSE 8134
EXPOSE 1111

WORKDIR /root

CMD ["/root/start.sh"]
