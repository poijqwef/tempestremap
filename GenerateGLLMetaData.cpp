///////////////////////////////////////////////////////////////////////////////
///
///	\file    GenerateGLLMetaData.cpp
///	\author  Paul Ullrich
///	\version August 12, 2014
///
///	<remarks>
///		Copyright 2000-2014 Paul Ullrich
///
///		This file is distributed as part of the Tempest source code package.
///		Permission is granted to use, copy, modify and distribute this
///		source code and its documentation under the terms of the GNU General
///		Public License.  This software is provided "as is" without express
///		or implied warranty.
///	</remarks>

#include "Announce.h"
#include "CommandLine.h"
#include "Exception.h"
#include "GridElements.h"
#include "DataMatrix3D.h"
#include "GaussLobattoQuadrature.h"
#include "FiniteElementTools.h"

#include "netcdfcpp.h"

///////////////////////////////////////////////////////////////////////////////

int main(int argc, char** argv) {

try {

	// Input mesh
	std::string strMesh;

	// Polynomial order
	int nP;

	// Output metadata file
	std::string strOutput;

	// Parse the command line
	BeginCommandLine()
		CommandLineString(strMesh, "mesh", "");
		CommandLineInt(nP, "np", 4);
		CommandLineString(strOutput, "out", "gllmeta.nc");

		ParseCommandLine(argc, argv);
	EndCommandLine(argv)

	AnnounceBanner();

	// Check data
	if (strMesh == "") {
		_EXCEPTION1("Invalid input mesh file \"%s\"", strMesh.c_str());
	}

	// Load in the input mesh
	AnnounceStartBlock("Loading Mesh");
	Mesh meshInput(strMesh);
	AnnounceEndBlock(NULL);

	// Calculate metadata
	DataMatrix3D<int> dataGLLnodes;
	DataMatrix3D<double> dataGLLJacobian;

	AnnounceStartBlock("Calculating Metadata");
	double dAccumulatedJacobian =
		GenerateMetaData(
			meshInput,
			nP,
			dataGLLnodes,
			dataGLLJacobian
		);

	Announce("Accumulated J: %1.15e (Error %1.15e)\n",
		dAccumulatedJacobian, dAccumulatedJacobian - 4.0 * M_PI);
	AnnounceEndBlock(NULL);

	// Number of Faces
	int nElements = static_cast<int>(meshInput.faces.size());

	// Write to file
	NcFile ncOut(strOutput.c_str(), NcFile::Replace);
	NcDim * dimElements = ncOut.add_dim("nelem", nElements);
	NcDim * dimNp = ncOut.add_dim("np", nP);

	NcVar * varGLLnodes =
		ncOut.add_var("GLLnodes", ncInt, dimNp, dimNp, dimElements);

	NcVar * varJacobian =
		ncOut.add_var("J", ncDouble, dimNp, dimNp, dimElements);

	varGLLnodes->put(&(dataGLLnodes[0][0][0]), nP, nP, nElements);

	varJacobian->put(&(dataGLLJacobian[0][0][0]), nP, nP, nElements);

	// Done
	AnnounceBanner();

} catch(Exception & e) {
	Announce(e.ToString().c_str());
}
}

///////////////////////////////////////////////////////////////////////////////
