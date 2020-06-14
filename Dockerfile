FROM ubuntu:bionic

RUN apt-get update
RUN apt -y install mongodb wget git gcc cmake autoconf libtool pkg-config libmnl-dev libyaml-dev vim
RUN wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz
RUN tar -C /usr/local -zxvf go1.12.9.linux-amd64.tar.gz
RUN mkdir -p ~/go/{bin,pkg,src}
WORKDIR /root
ENV GOPATH /root/go
ENV GOROOT /usr/local/go 
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin
ENV GO111MODULE off 
RUN go get -u github.com/sirupsen/logrus
WORKDIR $GOPATH/src
RUN git clone https://github.com/free5gc/free5gc.git
WORKDIR free5gc
RUN git submodule update --init
WORKDIR $GOPATH/src/free5gc
RUN ./install_env.sh
RUN ./build.sh
