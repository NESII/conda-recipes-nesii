#!/usr/bin/env bash

BC="conda build -c conda-forge "

${BC} gdal && \
${BC} fiona && \
${BC} hdf5 && \
${BC} libnetcdf && \
${BC} mpi4py && \
${BC} netcdf4-python && \
${BC} ocgis