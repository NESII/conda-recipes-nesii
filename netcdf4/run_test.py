import netCDF4 as nc


ds = nc.Dataset('/tmp/foo.nc', mode='w', parallel=True)
ds.close()
