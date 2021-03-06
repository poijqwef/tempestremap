##############################################################################
# Compiler and flags

INSTALL_DIR=${BIN_DIR}
ifeq ($(INSTALL_DIR),)
	INSTALL_DIR=../bin
endif

CC=${CPP_COMPILER}
CCOMP=${C_COMPILER}
CFLAGS+=-O3

# NETCDF library directories
NETCDF_INCLUDEDIR=${NETCDF_INC}
NETCDF_LIBDIR=${NETCDF_LIB}

# Library files to include
UNAME=$(shell uname)
ifeq ($(UNAME), Linux)
	LDFILES+= -lnetcdf_c++ -lnetcdf -Wl,-rpath=${NETCDF_LIBDIR}
else
	LDFILES+= -lnetcdf -lnetcdf_c++ -framework accelerate
endif

$(info $$NETCDF_INCLUDEDIR is [${NETCDF_INCLUDEDIR}])
$(info $$NETCDF_LIBDIR is [${NETCDF_LIBDIR}])
$(info $$LDFILES is [${LDFILES}])
$(info $$INSTALL_DIR is [${INSTALL_DIR}])

##############################################################################
# DO NOT MODIFY BELOW THIS LINE
##############################################################################

# Local files
FILES= Announce.cpp \
       PolynomialInterp.cpp \
       GridElements.cpp \
       MeshUtilities.cpp \
       MeshUtilitiesFuzzy.cpp \
       MeshUtilitiesExact.cpp \
       GaussQuadrature.cpp \
       GaussLobattoQuadrature.cpp \
	   LegendrePolynomial.cpp \
       FiniteElementTools.cpp \
       NetCDFUtilities.cpp \
       OfflineMap.cpp \
       TriangularQuadrature.cpp

GENERATERLLMESH_FILES= GenerateRLLMesh.cpp $(FILES)

GENERATECSMESH_FILES= GenerateCSMesh.cpp $(FILES)

GENERATEICOMESH_FILES= GenerateICOMesh.cpp $(FILES)

GENERATELAMBERTCONFCONICMESH_FILES = GenerateLambertConfConicMesh.cpp $(FILES)

GENERATEVOLUMETRICMESH_FILES = GenerateVolumetricMesh.cpp $(FILES)

GENERATEOVERLAPMESH_FILES= GenerateOverlapMesh.cpp OverlapMesh.cpp $(FILES)
GENERATEOVERLAPMESH_CFILES= kdtree.c

GENERATEOVERLAPMESHV1_FILES= GenerateOverlapMesh_v1.cpp OverlapMesh.cpp $(FILES)
GENERATEOVERLAPMESHV1_CFILES= kdtree.c

GENERATEGLLMETADATA_FILES= GenerateGLLMetaData.cpp $(FILES)

MESHTOTXT_FILES= MeshToTxt.cpp $(FILES)

GENERATETESTDATA_FILES= GenerateTestData.cpp $(FILES)

CALCULATEDIFFNORMS_FILES= CalculateDiffNorms.cpp $(FILES)

APPLYOFFLINEMAP_FILES= ApplyOfflineMap.cpp $(FILES)

GENERATEOFFLINEMAP_FILES= GenerateOfflineMap.cpp LinearRemapSE0.cpp LinearRemapFV.cpp OverlapMesh.cpp $(FILES)
GENERATEOFFLINEMAP_CFILES= kdtree.c

GENERATEOFFLINEMAPV1_FILES= GenerateOfflineMap_v1.cpp LinearRemapSE0.cpp LinearRemapFV.cpp $(FILES)

# Load system-specific defaults
CFLAGS+= -I$(NETCDF_INCLUDEDIR)
LDFLAGS+= -L$(NETCDF_LIBDIR)

include Make.defs

##
## Build instructions
##
all: GenerateRLLMesh GenerateCSMesh GenerateICOMesh GenerateVolumetricMesh GenerateLambertConfConicMesh GenerateOverlapMesh GenerateOverlapMesh_v1 GenerateGLLMetaData MeshToTxt GenerateTestData CalculateDiffNorms ApplyOfflineMap GenerateOfflineMap
	mkdir -p $(INSTALL_DIR)
	mv $^ $(INSTALL_DIR)/

GenerateRLLMesh: $(GENERATERLLMESH_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATERLLMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateCSMesh: $(GENERATECSMESH_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATECSMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateICOMesh: $(GENERATEICOMESH_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATEICOMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateLambertConfConicMesh: $(GENERATELAMBERTCONFCONICMESH_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATELAMBERTCONFCONICMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateVolumetricMesh: $(GENERATEVOLUMETRICMESH_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATEVOLUMETRICMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateOverlapMesh: $(GENERATEOVERLAPMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(GENERATEOVERLAPMESH_CFILES:%.c=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATEOVERLAPMESH_FILES:%.cpp=$(BUILDDIR)/%.o) $(GENERATEOVERLAPMESH_CFILES:%.c=$(BUILDDIR)/%.o) $(LDFILES)

GenerateOverlapMesh_v1: $(GENERATEOVERLAPMESHV1_FILES:%.cpp=$(BUILDDIR)/%.o) $(GENERATEOVERLAPMESHV1_CFILES:%.c=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATEOVERLAPMESHV1_FILES:%.cpp=$(BUILDDIR)/%.o) $(GENERATEOVERLAPMESHV1_CFILES:%.c=$(BUILDDIR)/%.o) $(LDFILES)

GenerateGLLMetaData: $(GENERATEGLLMETADATA_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATEGLLMETADATA_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

MeshToTxt: $(MESHTOTXT_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(MESHTOTXT_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateTestData: $(GENERATETESTDATA_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATETESTDATA_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

CalculateDiffNorms: $(CALCULATEDIFFNORMS_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(CALCULATEDIFFNORMS_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

ApplyOfflineMap: $(APPLYOFFLINEMAP_FILES:%.cpp=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(APPLYOFFLINEMAP_FILES:%.cpp=$(BUILDDIR)/%.o) $(LDFILES)

GenerateOfflineMap: $(GENERATEOFFLINEMAP_FILES:%.cpp=$(BUILDDIR)/%.o) $(GENERATEOFFLINEMAP_CFILES:%.c=$(BUILDDIR)/%.o)
	$(CC) $(LDFLAGS) -o $@ $(GENERATEOFFLINEMAP_FILES:%.cpp=$(BUILDDIR)/%.o) $(GENERATEOFFLINEMAP_CFILES:%.c=$(BUILDDIR)/%.o) $(LDFILES)

##
## Clean
##
clean:
	rm -f GenerateRLLMesh GenerateCSMesh GenerateICOMesh GenerateLambertConfConicMesh GenerateOverlapMesh GenerateGLLMetaData MeshToTxt GenerateTestData CalculateDiffNorms ApplyOfflineMap GenerateOfflineMap *.o
	rm -rf $(DEPDIR)
	rm -rf $(BUILDDIR)
	rm -rf $(INSTALL_DIR)/GenerateRLLMesh $(INSTALL_DIR)/GenerateCSMesh $(INSTALL_DIR)/GenerateICOMesh $(INSTALL_DIR)/GenerateLambertConfConicMesh $(INSTALL_DIR)/GenerateOverlapMesh $(INSTALL_DIR)/GenerateGLLMetaData $(INSTALL_DIR)/MeshToTxt $(INSTALL_DIR)/GenerateTestData $(INSTALL_DIR)/CalculateDiffNorms $(INSTALL_DIR)/ApplyOfflineMap $(INSTALL_DIR)/GenerateOfflineMap

##
## Include dependencies
##
include $(FILES:%.cpp=$(DEPDIR)/%.d)

# DO NOT DELETE

OfflineMap.o: OfflineMap.h SparseMatrix.h Defines.h DataVector.h Exception.h
OfflineMap.o: DataMatrix.h DataMatrix3D.h NetCDFUtilities.h GridElements.h
OfflineMap.o: FiniteElementTools.h Announce.h
