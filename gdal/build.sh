#!/bin/bash

CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"

./configure --prefix=${PREFIX} \
            --with-geos=${PREFIX}/bin/geos-config \
            --with-static-proj4=${PREFIX} \
            --with-python \
            --without-pam \
            --with-curl

make -j ${CPU_COUNT}
make install

# Copy data files.
mkdir -p ${PREFIX}/share/gdal/
cp data/*csv ${PREFIX}/share/gdal/
cp data/*wkt ${PREFIX}/share/gdal/
