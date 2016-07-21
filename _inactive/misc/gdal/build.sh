#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64:${DYLD_LIBRARY_PATH}
else
    export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64:${LD_LIBRARY_PATH}
fi

#./configure LIBS="-ludunits2" --prefix=$PREFIX \

./configure --prefix=$PREFIX \
            --with-geos=$PREFIX/bin/geos-config \
            --with-hdf5=$PREFIX \
            --with-netcdf=$PREFIX \
            --without-pam \
            --with-python \
            --disable-rpath

#--with-xerces=$PREFIX \
#--with-static-proj4=$PREFIX \
#--with-jpeg=$PREFIX \
#--with-jasper=$PREFIX \

make -j ${CPUCOUNT}
make install

# Copy data files 
mkdir -p $PREFIX/share/gdal/
cp -f data/* $PREFIX/share/gdal
cp -f LICENSE.TXT $PREFIX/share/gdal

