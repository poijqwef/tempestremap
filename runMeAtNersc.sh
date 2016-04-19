#!/bin/bash

module load cray-libsci

[ 0 -eq 1 ] && echo ./hdf5-netcdf.sh
libDir=`pwd`/Local

codeDir=`pwd`
cd $codeDir
export CPP_COMPILER=g++
export C_COMPILER=gcc
export CFLAGS="-std=c++0x"

export LDFILES="-L$CRAY_LIBSCI_PREFIX_DIR/lib -lsci_intel"

make clean
make NETCDF_LIB=$libDir/lib NETCDF_INC=$libDir/include

