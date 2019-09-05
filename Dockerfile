FROM ubuntu

RUN apt-get -y update; \
    apt-get -y install git wget curl; 
    #cd /opt; \
    #wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2-Linux-x86_64.sh; \
    #chmod +x /opt/cmake-3.15.2-Linux-x86_64.sh; \
    #mkdir /opt/cmake; \
    #/opt/cmake-3.15.2-Linux-x86_64.sh --skip-license --include-subdir --prefix=/opt/cmake; \
    #ln -s /opt/cmake/cmake-3.15.2-Linux-x86_64/bin/* /usr/local/bin; \

RUN apt-get update 
RUN apt-get -y install libmicrohttpd-dev libxml2-dev build-essential ; 

RUN apt-get -y install make cmake

RUN curl --silent --show-error https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - ; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
    curl --silent --show-error https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -; \
    echo "deb https://deb.nodesource.com/node_8.x stretch main" | tee /etc/apt/sources.list.d/nodesource.list; \
    apt-get -y update; 
RUN apt-get install -y nodejs yarn

RUN apt-get install -y gettext
##RUN apt-get -y install gcc-c++ 
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py; \
    chmod +x ./get-pip.py; \
    ./get-pip.py; \
    pip install polib;

RUN apt-get -y install \
    pkg-config \
    libglib2.0-dev \
    libgpgme11-dev \
    libgnutls28-dev \
    uuid-dev \
    libssh-gcrypt-dev \
    libldap2-dev \
    libhiredis-dev

RUN git clone https://github.com/greenbone/gvm-libs; \
    cd /gvm-libs; \
    mkdir build; \
    cd build; \
    cmake .. ; \
    make install ;


RUN git clone https://github.com/greenbone/gsa; \
    cd /gsa; \ 
    mkdir build; \
    cd build; \
    cmake .. ; \ 
    make install;
RUN export LD_LIBRARY_PATH=/usr/local/lib
EXPOSE 443

##CMD [ "/bin/bash" ]
##CMD [ "/usr/local/sbin/gsad" ]
CMD ["/usr/local/sbin/gsad --listen=0.0.0.0 --port=443 --foreground --verbose"]