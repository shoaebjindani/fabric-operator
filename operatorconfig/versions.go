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

func getDefaultVersions() *deployer.Versions {
	return &deployer.Versions{
		CA: map[string]deployer.VersionCA{
			"1.5.9-2": {
				Default: true,
				Version: "1.5.9-2",
				Image: deployer.CAImages{
					CAInitImage:    "ibm-hlfsupport-init",
					CAInitTag:      "1.0.9-20240402-amd64",
					CAInitDigest:   "sha256:777f7fdcc2df5b098cf5fc216deaf8a5daec0d1ef9c2322720e653cf5a95df5e",
					CAImage:        "ibm-hlfsupport-ca",
					CATag:          "1.5.9-20240402-amd64",
					CADigest:       "sha256:38bddc3dae5d09d86fc45dc03e727d3d108e8dfa39957dd23dccd88e3aa7c4df",
					EnrollerImage:  "ibm-hlfsupport-enroller",
					EnrollerTag:    "1.0.9-20240402-amd64",
					EnrollerDigest: "sha256:b370d138832fd9ae771ecbe9a47ce5f6e7f106bd4b636cb5c3349839672b022b",
				},
			},
		},
		Peer: map[string]deployer.VersionPeer{
			"2.2.15-2": {
				Default: true,
				Version: "2.2.15-2",
				Image: deployer.PeerImages{
					PeerInitImage:    "ibm-hlfsupport-init",
					PeerInitTag:      "1.0.9-20240402-amd64",
					PeerInitDigest:   "sha256:777f7fdcc2df5b098cf5fc216deaf8a5daec0d1ef9c2322720e653cf5a95df5e",
					PeerImage:        "ibm-hlfsupport-peer",
					PeerTag:          "2.2.15-20240402-amd64",
					PeerDigest:       "sha256:bd0b79212dd2baed3caba6f8bb4596657206a5aa97eb2ce3158e1a89d87c6a4a",
					CouchDBImage:     "ibm-hlfsupport-couchdb",
					CouchDBTag:       "3.3.3-20240402-amd64",
					CouchDBDigest:    "sha256:89dad7f96725694cd1a58c7ff74b4a4f1dd30cc38582364eefaf26c597d52ae0",
					GRPCWebImage:     "ibm-hlfsupport-grpcweb",
					GRPCWebTag:       "1.0.9-20240402-amd64",
					GRPCWebDigest:    "sha256:1604727deda11513c1aa3e36ae08ea09eb4e7c522b4972883eaffcd3089e0476",
					CCLauncherImage:  "ibm-hlfsupport-chaincode-launcher",
					CCLauncherTag:    "2.2.15-20240402-amd64",
					CCLauncherDigest: "sha256:7d80087b217e3cb13d6541dca509b9ed382097ce3947aefd869976a346de47cf",
					BuilderImage:     "ibm-hlfsupport-ccenv",
					BuilderTag:       "2.2.15-20240402-amd64",
					BuilderDigest:    "sha256:d96fbe7ff58b08497ac0e561fa0e4fcf775bae3d3291f80eab8a61bb30f9dd41",
					GoEnvImage:       "ibm-hlfsupport-goenv",
					GoEnvTag:         "2.2.15-20240402-amd64",
					GoEnvDigest:      "sha256:ad18e28e8ccab034a0d1867ab00a916a525f57f6c4447b369221e73aee3b5dcd",
					JavaEnvImage:     "ibm-hlfsupport-javaenv",
					JavaEnvTag:       "2.2.15-20240402-amd64",
					JavaEnvDigest:    "sha256:24a2867a0991d2ade0f9ca9b527c8c8605891c24c3b53e1b02aebb812f2867f5",
					NodeEnvImage:     "ibm-hlfsupport-nodeenv",
					NodeEnvTag:       "2.2.15-20240402-amd64",
					NodeEnvDigest:    "sha256:0ed4689447083dd5d18fdf41cf3d96eb23a8f19922c7250038e2b2842eed46a8",
					EnrollerImage:    "ibm-hlfsupport-enroller",
					EnrollerTag:      "1.0.9-20240402-amd64",
					EnrollerDigest:   "sha256:b370d138832fd9ae771ecbe9a47ce5f6e7f106bd4b636cb5c3349839672b022b",
				},
			},
			"2.5.6-2": {
				Default: false,
				Version: "2.5.6-2",
				Image: deployer.PeerImages{
					PeerInitImage:    "ibm-hlfsupport-init",
					PeerInitTag:      "1.0.9-20240402-amd64",
					PeerInitDigest:   "sha256:777f7fdcc2df5b098cf5fc216deaf8a5daec0d1ef9c2322720e653cf5a95df5e",
					PeerImage:        "ibm-hlfsupport-peer",
					PeerTag:          "2.5.6-20240402-amd64",
					PeerDigest:       "sha256:ba521fd506c545c0c7672b5004d1f91e4ec18c1fd79516357d944335bdf248d7",
					CouchDBImage:     "ibm-hlfsupport-couchdb",
					CouchDBTag:       "3.3.3-20240402-amd64",
					CouchDBDigest:    "sha256:89dad7f96725694cd1a58c7ff74b4a4f1dd30cc38582364eefaf26c597d52ae0",
					GRPCWebImage:     "ibm-hlfsupport-grpcweb",
					GRPCWebTag:       "1.0.9-20240402-amd64",
					GRPCWebDigest:    "sha256:1604727deda11513c1aa3e36ae08ea09eb4e7c522b4972883eaffcd3089e0476",
					CCLauncherImage:  "ibm-hlfsupport-chaincode-launcher",
					CCLauncherTag:    "2.5.6-20240402-amd64",
					CCLauncherDigest: "sha256:daac14e557a328555bafb0a185679c8b0cab7b5663898bb2a2b88c6383f5cafa",
					BuilderImage:     "ibm-hlfsupport-ccenv",
					BuilderTag:       "2.5.6-20240402-amd64",
					BuilderDigest:    "sha256:e09f1e5711776ee01948332056b90fe553a58d1f48f733c41e563bb7b403a910",
					GoEnvImage:       "ibm-hlfsupport-goenv",
					GoEnvTag:         "2.5.6-20240402-amd64",
					GoEnvDigest:      "sha256:b57459109d3346788d3520542ab1b3424858e2d5ec55dd1eb4cad919aebdc6d2",
					JavaEnvImage:     "ibm-hlfsupport-javaenv",
					JavaEnvTag:       "2.5.6-20240402-amd64",
					JavaEnvDigest:    "sha256:21e49a7792d2486cd86346736bfaafd4763bc746a6508addef6374efe3aa7abf",
					NodeEnvImage:     "ibm-hlfsupport-nodeenv",
					NodeEnvTag:       "2.5.6-20240402-amd64",
					NodeEnvDigest:    "sha256:b94d376a8d97ae8088d0100fbe239d2e85ef0238c217e2471d6db478061f6f54",
					EnrollerImage:    "ibm-hlfsupport-enroller",
					EnrollerTag:      "1.0.9-20240402-amd64",
					EnrollerDigest:   "sha256:b370d138832fd9ae771ecbe9a47ce5f6e7f106bd4b636cb5c3349839672b022b",
				},
			},
		},
		Orderer: map[string]deployer.VersionOrderer{
			"2.2.15-2": {
				Default: true,
				Version: "2.2.15-2",
				Image: deployer.OrdererImages{
					OrdererInitImage:  "ibm-hlfsupport-init",
					OrdererInitTag:    "1.0.9-20240402-amd64",
					OrdererInitDigest: "sha256:777f7fdcc2df5b098cf5fc216deaf8a5daec0d1ef9c2322720e653cf5a95df5e",
					OrdererImage:      "ibm-hlfsupport-orderer",
					OrdererTag:        "2.2.15-20240402-amd64",
					OrdererDigest:     "sha256:55e5ea874f4e945d950a0d3015c6e0bde51e865190231b798d5b1b6032d78b91",
					GRPCWebImage:      "ibm-hlfsupport-grpcweb",
					GRPCWebTag:        "1.0.9-20240402-amd64",
					GRPCWebDigest:     "sha256:1604727deda11513c1aa3e36ae08ea09eb4e7c522b4972883eaffcd3089e0476",
					EnrollerImage:     "ibm-hlfsupport-enroller",
					EnrollerTag:       "1.0.9-20240402-amd64",
					EnrollerDigest:    "sha256:b370d138832fd9ae771ecbe9a47ce5f6e7f106bd4b636cb5c3349839672b022b",
				},
			},
			"2.5.6-2": {
				Default: false,
				Version: "2.5.6-2",
				Image: deployer.OrdererImages{
					OrdererInitImage:  "ibm-hlfsupport-init",
					OrdererInitTag:    "1.0.9-20240402-amd64",
					OrdererInitDigest: "sha256:777f7fdcc2df5b098cf5fc216deaf8a5daec0d1ef9c2322720e653cf5a95df5e",
					OrdererImage:      "ibm-hlfsupport-orderer",
					OrdererTag:        "2.5.6-20240402-amd64",
					OrdererDigest:     "sha256:19a22accbf6f683256d4398c8f545332b38037ee477f02af0a58fd0304d11d57",
					GRPCWebImage:      "ibm-hlfsupport-grpcweb",
					GRPCWebTag:        "1.0.9-20240402-amd64",
					GRPCWebDigest:     "sha256:1604727deda11513c1aa3e36ae08ea09eb4e7c522b4972883eaffcd3089e0476",
					EnrollerImage:     "ibm-hlfsupport-enroller",
					EnrollerTag:       "1.0.9-20240402-amd64",
					EnrollerDigest:    "sha256:b370d138832fd9ae771ecbe9a47ce5f6e7f106bd4b636cb5c3349839672b022b",
				},
			},
		},
	}
}
