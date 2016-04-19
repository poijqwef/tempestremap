##
## Build instructions
##

ifndef NETCDF_LIB
	$(error Please, pass NETCDF_LIB=   )
endif
ifndef NETCDF_INC
	$(error Please, pass NETCDF_INC=   )
endif

all:

	cd src; make

##
## Clean
##
clean:
	cd src; make clean
	rm -f bin/*

# DO NOT DELETE
