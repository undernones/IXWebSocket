FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update 
RUN apt-get -y install g++ 
RUN apt-get -y install libssl-dev
RUN apt-get -y install gdb
RUN apt-get -y install screen
RUN apt-get -y install procps
RUN apt-get -y install lsof
RUN apt-get -y install libz-dev
RUN apt-get -y install vim
RUN apt-get -y install make
RUN apt-get -y install cmake
RUN apt-get -y install curl
RUN apt-get -y install python
RUN apt-get -y install netcat

# debian strech cmake is too old for building with Docker
COPY makefile .
RUN ["make", "install_cmake_for_linux"]

COPY . .

ARG CMAKE_BIN_PATH=/tmp/cmake/cmake-3.14.0-rc4-Linux-x86_64/bin
ENV PATH="${CMAKE_BIN_PATH}:${PATH}"

# RUN ["make"]

EXPOSE 8765
CMD ["/ws/ws", "transfer", "--port", "8765", "--host", "0.0.0.0"]
