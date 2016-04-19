#!/bin/bash

installDir=`pwd`/Local
[ ! -d $installDir ] && mkdir $installDir
cd $installDir

versionDir=hdf5-1.8.16
if [ ! -f ${versionDir}.tar.gz ]; then
    wget http://www.hdfgroup.org/ftp/HDF5/current/src/${versionDir}.tar.gz
fi
rm -rf $versionDir
tar xzf ${versionDir}.tar.gz
cd $versionDir
./configure --prefix=$installDir -enable-hl --enable-shared
make uninstall
make clean
make -j8
make install

versionDir=netcdf-4.4.0
if [ ! -f ${versionDir}.tar.gz ]; then
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/${versionDir}.tar.gz
fi
rm -rf $versionDir
tar xzf ${versionDir}.tar.gz
cd $versionDir
export HDF5_DIR=$installDir
export CPPFLAGS="-I$HDF5_DIR/include"
export LDFLAGS="-L$HDF5_DIR/lib"
./configure --prefix=$installDir --enable-netcdf-4 --enable-shared
make uninstall
make clean
make -j8
make install

versionDir=netcdf-cxx-4.2
if [ ! -f ${versionDir}.tar.gz ]; then
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-cxx-4.2.tar.gz
fi
rm -rf $versionDir
tar xzf ${versionDir}.tar.gz
cd $versionDir
autoreconf -if
export HDF5_DIR=$installDir
export CPPFLAGS="-I$installDir/include"
export LDFLAGS="-L$HDF5_DIR/lib"
export NETCDF_LIB="$installDir/lib"
export NETCDF_INC="$installDir/include"
./configure --prefix=$installDir --enable-netcdf-4
make uninstall
make clean
make -j8
make install

versionDir=netcdf-cxx4-4.2
if [ ! -f ${versionDir}.tar.gz ]; then
    wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-cxx4-4.2.tar.gz
fi
rm -rf $versionDir
tar xzf ${versionDir}.tar.gz
cd $versionDir
autoreconf -if
export HDF5_DIR=$installDir
export CPPFLAGS="-I$installDir/include"
export LDFLAGS="-L$HDF5_DIR/lib"
export NETCDF_LIB="$installDir/lib"
export NETCDF_INC="$installDir/include"
./configure --prefix=$installDir --enable-netcdf-4
make uninstall
make clean
make -j8
make install
