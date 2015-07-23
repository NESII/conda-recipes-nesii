#!/bin/sh

export DFN="proj-datumgrid-1.5.zip"
curl -O http://download.osgeo.org/proj/${DFN}
unzip ${DFN} -d ./nad/

./configure --prefix=$PREFIX --without-jni

make -j ${CPUCOUNT}
make check || exit 1
make install
