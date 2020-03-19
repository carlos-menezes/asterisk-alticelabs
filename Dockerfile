FROM centos:7

WORKDIR /home/ 
RUN curl -O https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
RUN tar -zxvf asterisk-16-current.tar.gz
RUN rm -rf asterisk-16-current.tar.gz
WORKDIR /home/asterisk-16.9.0/

# DEPENDENCIES
# Update pkg repo
RUN yum -y update 
RUN yum -y group install "Development Tools"

WORKDIR /usr/src/
RUN git clone https://github.com/akheron/jansson.git
WORKDIR /usr/src/jansson
RUN autoreconf  -i
RUN ./configure --prefix=/usr/
RUN make && make install

RUN yum -y install libedit-devel
RUN yum -y install libuuid-devel
RUN yum -y install jansson-devel
RUN yum -y install libxml2-devel
RUN yum -y install sqlite-devel
RUN yum -y install openssl-devel
RUN yum -y install newt-devel
RUN yum -y install kernel-headers
# RUN yum -y install kernel-devel
# RUN yum -y install kernel-devel-$(uname -r)

WORKDIR /home/asterisk-16.9.0/

RUN ./configure --libdir=/usr/lib64 --with-jansson-bundled --with-pjproject-bundled
RUN make menuselect.makeopts
RUN menuselect/menuselect \
  --enable BUILD_NATIVE \
  --enable cdr_csv \
  --enable chan_sip \
  --enable res_snmp \
  --enable res_pjsip \
  --enable chan_pjsip \
  --enable res_http_websocket \
  menuselect.makeopts
RUN make
RUN make install
RUN make samples

RUN rm -rf /etc/asterisk/sip.conf
COPY ./sip.conf /etc/asterisk/
RUN rm -rf /etc/asterisk/extensions.conf
COPY ./extensions.conf /etc/asterisk/

EXPOSE 5060/tcp 5060/udp
# PORTAS A EXPOR NO HOST: UDP 5060,4569,5036,10000-20000,2727
RUN echo "Run asterisk -cvvvvv to start Asterisk"