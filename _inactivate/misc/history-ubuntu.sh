#!/bin/bash

PREFIX=/home/ubuntu/install

sudo apt-get install build-essential gfortran m4
mkdir src

cd ~/src
mkdir gmp
cd gmp/
wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2
tar -xvjf gmp-5.1.2.tar.bz2
cd gmp-5.1.2/
./configure prefix=${PREFIX}/gmp
make install

cd ~/src
mkdir mpfr
cd mpfr/
wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2
rm gmp-5.1.2.tar.bz2
wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.bz2
tar -xjvf mpfr-3.1.2.tar.bz2
cd mpfr-3.1.2/
./configure prefix=${PREFIX}/mpfr --with-gmp-include=${PREFIX}/gmp/include --with-gmp-lib=${PREFIX}/gmp/lib
make
make install

cd ~/src
mkdir mpc
cd mpc
wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz
tar -xzvf mpc-1.0.1.tar.gz
cd mpc-1.0.1/
./configure --prefix=${PREFIX}/mpc \
            --with-gmp-include=${PREFIX}/gmp/include \
            --with-gmp-lib=${PREFIX}/gmp/lib \
            --with-mpfr-include=${PREFIX}/mpfr/include \
            --with-mpfr-lib=${PREFIX}/mpfr/lib
make
make install

cd ~/src
mkdir gcc
cd gcc/
wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-4.8.1/gcc-4.8.1.tar.bz2
tar -xvjf gcc-4.8.1.tar.bz2
cd gcc-4.8.1/
./configure --prefix=${PREFIX}/gcc \
            --enable-languages=c,c++,fortran \
            --enable-checking=release \
            --disable-bootstrap \
            --enable-threads \
            --with-gmp=${PREFIX}/gmp \
            --with-mpfr=${PREFIX}/mpfr \
            --with-mpc=${PREFIX}/mpc \
            --disable-multilib
make
make install
