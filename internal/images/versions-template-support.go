/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5900-AM9
 * (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
 * The source code for this program is not  published or otherwise divested of
 * its trade secrets, irrespective of what has been deposited with
 * the U.S. Copyright Office.
 ******************************************************************************/

package operatorconfig

import "github.com/IBM-Blockchain/fabric-operator/pkg/apis/deployer"

func getDefaultVersionsSupport() *deployer.Versions {
	return &deployer.Versions{
		CA: map[string]deployer.VersionCA{
			"1.5.9-2": {
				Default: true,
				Version: "1.5.9-2",
				Image: deployer.CAImages{
					CAInitImage:    "ibm-hlfsupport-init",
					CAInitTag:      "",
					CAInitDigest:   "",
					CAImage:        "ibm-hlfsupport-ca",
					CATag:          "",
					CADigest:       "",
					EnrollerImage:  "ibm-hlfsupport-enroller",
					EnrollerTag:    "",
					EnrollerDigest: "",
				},
			},
		},
		Peer: map[string]deployer.VersionPeer{
			"2.2.15-2": {
				Default: true,
				Version: "2.2.15-2",
				Image: deployer.PeerImages{
					PeerInitImage:    "ibm-hlfsupport-init",
					PeerInitTag:      "",
					PeerInitDigest:   "",
					PeerImage:        "ibm-hlfsupport-peer",
					PeerTag:          "peer22tag",
					PeerDigest:       "peer22digest",
					CouchDBImage:     "ibm-hlfsupport-couchdb",
					CouchDBTag:       "couchdb312tag",
					CouchDBDigest:    "couchdb312digest",
					GRPCWebImage:     "ibm-hlfsupport-grpcweb",
					GRPCWebTag:       "",
					GRPCWebDigest:    "",
					CCLauncherImage:  "ibm-hlfsupport-chaincode-launcher",
					CCLauncherTag:    "ccbuilder22tag",
					CCLauncherDigest: "ccbuilder22digest",
					BuilderImage:     "ibm-hlfsupport-ccenv",
					BuilderTag:       "ccenv22tag",
					BuilderDigest:    "ccenv22digest",
					GoEnvImage:       "ibm-hlfsupport-goenv",
					GoEnvTag:         "goenv22tag",
					GoEnvDigest:      "goenv22digest",
					JavaEnvImage:     "ibm-hlfsupport-javaenv",
					JavaEnvTag:       "javaenv22tag",
					JavaEnvDigest:    "javaenv22digest",
					NodeEnvImage:     "ibm-hlfsupport-nodeenv",
					NodeEnvTag:       "nodeenv22tag",
					NodeEnvDigest:    "nodeenv22digest",
					EnrollerImage:    "ibm-hlfsupport-enroller",
					EnrollerTag:      "",
					EnrollerDigest:   "",
				},
			},
			"2.5.6-2": {
				Default: false,
				Version: "2.5.6-2",
				Image: deployer.PeerImages{
					PeerInitImage:    "ibm-hlfsupport-init",
					PeerInitTag:      "",
					PeerInitDigest:   "",
					PeerImage:        "ibm-hlfsupport-peer",
					PeerTag:          "peer25tag",
					PeerDigest:       "peer25digest",
					CouchDBImage:     "ibm-hlfsupport-couchdb",
					CouchDBTag:       "couchdb312tag",
					CouchDBDigest:    "couchdb312digest",
					GRPCWebImage:     "ibm-hlfsupport-grpcweb",
					GRPCWebTag:       "",
					GRPCWebDigest:    "",
					CCLauncherImage:  "ibm-hlfsupport-chaincode-launcher",
					CCLauncherTag:    "ccbuilder25tag",
					CCLauncherDigest: "ccbuilder25digest",
					BuilderImage:     "ibm-hlfsupport-ccenv",
					BuilderTag:       "ccenv25tag",
					BuilderDigest:    "ccenv25digest",
					GoEnvImage:       "ibm-hlfsupport-goenv",
					GoEnvTag:         "goenv25tag",
					GoEnvDigest:      "goenv25digest",
					JavaEnvImage:     "ibm-hlfsupport-javaenv",
					JavaEnvTag:       "javaenv25tag",
					JavaEnvDigest:    "javaenv25digest",
					NodeEnvImage:     "ibm-hlfsupport-nodeenv",
					NodeEnvTag:       "nodeenv25tag",
					NodeEnvDigest:    "nodeenv25digest",
					EnrollerImage:    "ibm-hlfsupport-enroller",
					EnrollerTag:      "",
					EnrollerDigest:   "",
				},
			},
		},
		Orderer: map[string]deployer.VersionOrderer{
			"2.2.15-2": {
				Default: true,
				Version: "2.2.15-2",
				Image: deployer.OrdererImages{
					OrdererInitImage:  "ibm-hlfsupport-init",
					OrdererInitTag:    "",
					OrdererInitDigest: "",
					OrdererImage:      "ibm-hlfsupport-orderer",
					OrdererTag:        "orderer22tag",
					OrdererDigest:     "orderer22digest",
					GRPCWebImage:      "ibm-hlfsupport-grpcweb",
					GRPCWebTag:        "",
					GRPCWebDigest:     "",
					EnrollerImage:     "ibm-hlfsupport-enroller",
					EnrollerTag:       "",
					EnrollerDigest:    "",
				},
			},
			"2.5.6-2": {
				Default: false,
				Version: "2.5.6-2",
				Image: deployer.OrdererImages{
					OrdererInitImage:  "ibm-hlfsupport-init",
					OrdererInitTag:    "",
					OrdererInitDigest: "",
					OrdererImage:      "ibm-hlfsupport-orderer",
					OrdererTag:        "orderer25tag",
					OrdererDigest:     "orderer25digest",
					GRPCWebImage:      "ibm-hlfsupport-grpcweb",
					GRPCWebTag:        "",
					GRPCWebDigest:     "",
					EnrollerImage:     "ibm-hlfsupport-enroller",
					EnrollerTag:       "",
					EnrollerDigest:    "",
				},
			},
		},
	}
}

