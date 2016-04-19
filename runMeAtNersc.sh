#!/bin/bash

[ 0 -eq 1 ] && echo ./hdf5-netcdf.sh
libDir=`pwd`/Local

codeDir=`pwd`
cd $codeDir
export CPP_COMPILER=CC
export C_COMPILER=cc
export CPPFLAG="-mkl -std=c++0x"
export CFLAGS="-mkl -std=c++0x"
export LDFILES="-mkl"
#export LDFILES="-mkl -lblas --llapack"

make NETCDF_LIB=$libDir/lib NETCDF_INC=$libDir/include

