#*******************************************************************************
# IBM Confidential
# OCO Source Materials
# 5900-AM9
# (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
# The source code for this program is not  published or otherwise divested of
# its trade secrets, irrespective of what has been deposited with
# the U.S. Copyright Office.
#*******************************************************************************

#!/bin/bash -e

# if deployer-configmap.yaml is updated, update the template file deployer-configmap-template.yaml
DIGESTS_FILE=$1

if [[ ! -f "$DIGESTS_FILE" ]]; then
    echo "file $DIGESTS_FILE not found"
    echo "usage: ./update_script.sh <digest-file-name>"
    exit 0
fi

cp versions-template-${PRODUCT}.go temp.go

if [[ ${PRODUCT} = "support" ]]; then
    REGISTRY_NS="ibm-hlfsupport"
    sed -i.bak "s|getDefaultVersionsSupport|getDefaultVersions|g" temp.go
elif [[ ${PRODUCT} = "ibp" ]]; then
    REGISTRY_NS="ibp"
    sed -i.bak "s|getDefaultVersionsIbp|getDefaultVersions|g" temp.go
else
    echo "INVALID PRODUCT. It can be either support or ibp, exiting ..."
    exit 0
fi

cp deployer-configmap-template-${PRODUCT}.yaml temp.yaml

initDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-init | awk -F"@" '{print $2}')
echo "initDigest is $initDigest"
initTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-init | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "initTag is $initTag"
# CAInitDigest:     ""
sed -i.bak "s|CAInitDigest: .*$|CAInitDigest: \"${initDigest}\",|g" temp.go
sed -i.bak "s|caInitDigest: .*$|caInitDigest: ${initDigest}|g" temp.yaml
# CAInitTag:     ""
sed -i.bak "s|CAInitTag: .*$|CAInitTag: \"${initTag}\",|g" temp.go
sed -i.bak "s|caInitTag: .*$|caInitTag: ${initTag}|g" temp.yaml
# PeerInitDigest:   ""
sed -i.bak "s|PeerInitDigest: .*$|PeerInitDigest: \"${initDigest}\",|g" temp.go
sed -i.bak "s|peerInitDigest: .*$|peerInitDigest: ${initDigest}|g" temp.yaml
# PeerInitTag:   ""
sed -i.bak "s|PeerInitTag: .*$|PeerInitTag: \"${initTag}\",|g" temp.go
sed -i.bak "s|peerInitTag: .*$|peerInitTag: ${initTag}|g" temp.yaml
# OrdererInitDigest:   ""
sed -i.bak "s|OrdererInitDigest: .*$|OrdererInitDigest: \"${initDigest}\",|g" temp.go
sed -i.bak "s|ordererInitDigest: .*$|ordererInitDigest: ${initDigest}|g" temp.yaml
# OrdererInitTag:   ""
sed -i.bak "s|OrdererInitTag: .*$|OrdererInitTag: \"${initTag}\",|g" temp.go
sed -i.bak "s|ordererInitTag: .*$|ordererInitTag: ${initTag}|g" temp.yaml

caDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-ca | awk -F"@" '{print $2}')
echo "caDigest is $caDigest"
# CADigest:         ""
sed -i.bak "s|CADigest: .*$|CADigest: \"${caDigest}\",|g" temp.go
sed -i.bak "s|caDigest: .*$|caDigest: ${caDigest}|g" temp.yaml
caTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-ca | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "caTag is $caTag"
# CATag:         ""
sed -i.bak "s|CATag: .*$|CATag: \"${caTag}\",|g" temp.go
sed -i.bak "s|caTag: .*$|caTag: ${caTag}|g" temp.yaml

### PEER 2.2.x
peerDigest22=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-peer:2.2 | awk -F"@" '{print $2}')
echo "peerDigest22 is $peerDigest22"
# PeerDigest:     "peer22digest"
sed -i.bak "s|PeerDigest:       \"peer22digest\"|PeerDigest:       \"${peerDigest22}\"|g" temp.go
sed -i.bak "s|peerDigest: peer22digest|peerDigest: ${peerDigest22}|g" temp.yaml
peerTag22="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-peer:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "peerTag22 is $peerTag22"
# PeerTag:          "peer22tag"
sed -i.bak "s|PeerTag:          \"peer22tag\"|PeerTag: \"${peerTag22}\"|g" temp.go
sed -i.bak "s|peerTag: peer22tag|peerTag: ${peerTag22}|g" temp.yaml


### PEER 2.5.x
peerDigest25=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-peer:2.5 | awk -F"@" '{print $2}')
echo "peerDigest25 is $peerDigest25"
# PeerDigest:     "peer25digest"
sed -i.bak "s|PeerDigest:       \"peer25digest\"|PeerDigest:       \"${peerDigest25}\"|g" temp.go
sed -i.bak "s|peerDigest: peer25digest|peerDigest: ${peerDigest25}|g" temp.yaml
peerTag25="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-peer:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "peerTag25 is $peerTag25"
# PeerTag:          "peer25tag"
sed -i.bak "s|PeerTag:          \"peer25tag\"|PeerTag: \"${peerTag25}\"|g" temp.go
sed -i.bak "s|peerTag: peer25tag|peerTag: ${peerTag25}|g" temp.yaml

couchdbDigest312=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-couchdb:3.3.3 | awk -F"@" '{print $2}')
echo "couchdbDigest312 is $couchdbDigest312"
# CouchDBDigest:    "couchdb312digest"
sed -i.bak "s|CouchDBDigest:    \"couchdb312digest\"|CouchDBDigest: \"${couchdbDigest312}\"|g" temp.go
sed -i.bak "s|couchdbDigest: couchdb312digest|couchdbDigest: ${couchdbDigest312}|g" temp.yaml
couchdbTag312="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-couchdb:3.3.3 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "couchdbTag312 is $couchdbTag312"
# CouchDBTag:       "couchdb312tag"
sed -i.bak "s|CouchDBTag:       \"couchdb312tag\"|CouchDBTag: \"${couchdbTag312}\"|g" temp.go
sed -i.bak "s|couchdbTag: couchdb312tag|couchdbTag: ${couchdbTag312}|g" temp.yaml

grpcDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-grpcweb | awk -F"@" '{print $2}')
echo "grpcDigest is $grpcDigest"
# GRPCWebDigest:    ""
sed -i.bak "s|GRPCWebDigest: .*$|GRPCWebDigest: \"${grpcDigest}\",|g" temp.go
sed -i.bak "s|grpcwebDigest: .*$|grpcwebDigest: ${grpcDigest}|g" temp.yaml
grpcTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-grpcweb | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "grpcTag is $grpcTag"
# GRPCWebTag:    ""
sed -i.bak "s|GRPCWebTag: .*$|GRPCWebTag: \"${grpcTag}\",|g" temp.go
sed -i.bak "s|grpcwebTag: .*$|grpcwebTag: ${grpcTag}|g" temp.yaml

## ChaincodeLauncher for 2.2.x Peer Block
cclauncherDigest22=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-chaincode-launcher:2.2 | awk -F"@" '{print $2}')
echo "cclauncherDigest22 is $cclauncherDigest22"
# CCLauncherDigest:   ""
sed -i.bak "s|CCLauncherDigest: \"ccbuilder22digest\"|CCLauncherDigest:    \"${cclauncherDigest22}\"|g" temp.go
sed -i.bak "s|chaincodeLauncherDigest: ccbuilder22digest|chaincodeLauncherDigest: ${cclauncherDigest22}|g" temp.yaml
cclauncherTag22="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-chaincode-launcher:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "cclauncherTag22 is $cclauncherTag22"
# CCLauncherTag:   ""
sed -i.bak "s|CCLauncherTag:    \"ccbuilder22tag\"|CCLauncherTag:    \"${cclauncherTag22}\"|g" temp.go
sed -i.bak "s|chaincodeLauncherTag: ccbuilder22tag|chaincodeLauncherTag: ${cclauncherTag22}|g" temp.yaml


## ChaincodeLauncher for 2.5.x Peer Block
cclauncherDigest25=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-chaincode-launcher:2.5 | awk -F"@" '{print $2}')
echo "cclauncherDigest25 is $cclauncherDigest25"
# CCLauncherDigest:   ""
sed -i.bak "s|CCLauncherDigest: \"ccbuilder25digest\"|CCLauncherDigest:    \"${cclauncherDigest25}\"|g" temp.go
sed -i.bak "s|chaincodeLauncherDigest: ccbuilder25digest|chaincodeLauncherDigest: ${cclauncherDigest25}|g" temp.yaml
cclauncherTag25="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-chaincode-launcher:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "cclauncherTag25 is $cclauncherTag25"
# CCLauncherTag:   ""
sed -i.bak "s|CCLauncherTag:    \"ccbuilder25tag\"|CCLauncherTag:    \"${cclauncherTag25}\"|g" temp.go
sed -i.bak "s|chaincodeLauncherTag: ccbuilder25tag|chaincodeLauncherTag: ${cclauncherTag25}|g" temp.yaml

## ccenv for peer 2.2.x block
ccenvDigest22=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-ccenv:2.2 | awk -F"@" '{print $2}')
echo "ccenvDigest22 is $ccenvDigest22"
# BuilderDigest:      ""
sed -i.bak "s|BuilderDigest:    \"ccenv22digest\"|BuilderDigest:    \"${ccenvDigest22}\"|g" temp.go
sed -i.bak "s|builderDigest: ccenv22digest|builderDigest: ${ccenvDigest22}|g" temp.yaml
ccenvTag22="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-ccenv:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "ccenvTag22 is $ccenvTag22"
# BuilderTag:      ""
sed -i.bak "s|BuilderTag:       \"ccenv22tag\"|BuilderTag:       \"${ccenvTag22}\"|g" temp.go
sed -i.bak "s|builderTag: ccenv22tag|builderTag: ${ccenvTag22}|g" temp.yaml

## ccenv for peer 2.5.x block
ccenvDigest25=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-ccenv:2.5 | awk -F"@" '{print $2}')
echo "ccenvDigest25 is $ccenvDigest25"
# BuilderDigest:      ""
sed -i.bak "s|BuilderDigest:    \"ccenv25digest\"|BuilderDigest:    \"${ccenvDigest25}\"|g" temp.go
sed -i.bak "s|builderDigest: ccenv25digest|builderDigest: ${ccenvDigest25}|g" temp.yaml
ccenvTag25="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-ccenv:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "ccenvTag25 is $ccenvTag25"
# BuilderTag:      ""
sed -i.bak "s|BuilderTag:       \"ccenv25tag\"|BuilderTag:       \"${ccenvTag25}\"|g" temp.go
sed -i.bak "s|builderTag: ccenv25tag|builderTag: ${ccenvTag25}|g" temp.yaml

## goenv for peer 2.2.x block
goenvDigest22=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-goenv:2.2 | awk -F"@" '{print $2}')
echo "goenvDigest22 is $goenvDigest22"
# GoEnvDigest:        ""
sed -i.bak "s|GoEnvDigest:      \"goenv22digest\"|GoEnvDigest:      \"${goenvDigest22}\"|g" temp.go
sed -i.bak "s|goEnvDigest: goenv22digest|goEnvDigest: ${goenvDigest22}|g" temp.yaml
goenvTag22="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-goenv:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "goenvTag22 is $goenvTag22"
# GoEnvTag:        ""
sed -i.bak "s|GoEnvTag:         \"goenv22tag\"|GoEnvTag:         \"${goenvTag22}\"|g" temp.go
sed -i.bak "s|goEnvTag: goenv22tag|goEnvTag: ${goenvTag22}|g" temp.yaml

## goenv for peer 2.5.x block
goenvDigest25=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-goenv:2.5 | awk -F"@" '{print $2}')
echo "goenvDigest25 is $goenvDigest25"
# GoEnvDigest:        ""
sed -i.bak "s|GoEnvDigest:      \"goenv25digest\"|GoEnvDigest:      \"${goenvDigest25}\"|g" temp.go
sed -i.bak "s|goEnvDigest: goenv25digest|goEnvDigest: ${goenvDigest25}|g" temp.yaml
goenvTag25="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-goenv:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "goenvTag25 is $goenvTag25"
# GoEnvTag:        ""
sed -i.bak "s|GoEnvTag:         \"goenv25tag\"|GoEnvTag:         \"${goenvTag25}\"|g" temp.go
sed -i.bak "s|goEnvTag: goenv25tag|goEnvTag: ${goenvTag25}|g" temp.yaml

### javaenv for 2.2.x peer block
javaenvDigest22=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-javaenv:2.2 | awk -F"@" '{print $2}')
echo "javaenvDigest22 is $javaenvDigest22"
# JavaEnvDigest:      ""
sed -i.bak "s|JavaEnvDigest:    \"javaenv22digest\"|JavaEnvDigest:    \"${javaenvDigest22}\"|g" temp.go
sed -i.bak "s|javaEnvDigest: javaenv22digest|javaEnvDigest: ${javaenvDigest22}|g" temp.yaml
javaenvTag22="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-javaenv:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "javaenvTag22 is $javaenvTag22"
# JavaEnvTag:      ""
sed -i.bak "s|JavaEnvTag:       \"javaenv22tag\"|JavaEnvTag:       \"${javaenvTag22}\"|g" temp.go
sed -i.bak "s|javaEnvTag: javaenv22tag|javaEnvTag: ${javaenvTag22}|g" temp.yaml

### javaenv for 2.5.x peer block
javaenvDigest25=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-javaenv:2.5 | awk -F"@" '{print $2}')
echo "javaenvDigest25 is $javaenvDigest25"
# JavaEnvDigest:      ""
sed -i.bak "s|JavaEnvDigest:    \"javaenv25digest\"|JavaEnvDigest:    \"${javaenvDigest25}\"|g" temp.go
sed -i.bak "s|javaEnvDigest: javaenv25digest|javaEnvDigest: ${javaenvDigest25}|g" temp.yaml
javaenvTag25="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-javaenv:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "javaenvTag25 is $javaenvTag25"
# JavaEnvTag:      ""
sed -i.bak "s|JavaEnvTag:       \"javaenv25tag\"|JavaEnvTag:       \"${javaenvTag25}\"|g" temp.go
sed -i.bak "s|javaEnvTag: javaenv25tag|javaEnvTag: ${javaenvTag25}|g" temp.yaml

### nodeenv for 2.2.x peer block
nodeenvDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-nodeenv:2.2 | awk -F"@" '{print $2}')
echo "nodeenvDigest is $nodeenvDigest"
# NodeEnvDigest:      ""
sed -i.bak "s|NodeEnvDigest:    \"nodeenv22digest\"|NodeEnvDigest:    \"${nodeenvDigest}\"|g" temp.go
sed -i.bak "s|nodeEnvDigest: nodeenv22digest|nodeEnvDigest: ${nodeenvDigest}|g" temp.yaml
nodeenvTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-nodeenv:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "nodeenvTag is $nodeenvTag"
# NodeEnvTag:      ""
sed -i.bak "s|NodeEnvTag:       \"nodeenv22tag\"|NodeEnvTag:       \"${nodeenvTag}\"|g" temp.go
sed -i.bak "s|nodeEnvTag: nodeenv22tag|nodeEnvTag: ${nodeenvTag}|g" temp.yaml

### nodeenv for 2.5.x peer block
nodeenvDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-nodeenv:2.5 | awk -F"@" '{print $2}')
echo "nodeenvDigest is $nodeenvDigest"
# NodeEnvDigest:      ""
sed -i.bak "s|NodeEnvDigest:    \"nodeenv25digest\"|NodeEnvDigest:    \"${nodeenvDigest}\"|g" temp.go
sed -i.bak "s|nodeEnvDigest: nodeenv25digest|nodeEnvDigest: ${nodeenvDigest}|g" temp.yaml
nodeenvTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-nodeenv:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "nodeenvTag is $nodeenvTag"
# NodeEnvTag:      ""
sed -i.bak "s|NodeEnvTag:       \"nodeenv25tag\"|NodeEnvTag:       \"${nodeenvTag}\"|g" temp.go
sed -i.bak "s|nodeEnvTag: nodeenv25tag|nodeEnvTag: ${nodeenvTag}|g" temp.yaml

### ORDERER 2.2.x
ordererDigest22=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-orderer:2.2 | awk -F"@" '{print $2}')
echo "ordererDigest22 is $ordererDigest22"
# OrdererDigest:     "orderer22digest"
sed -i.bak "s|OrdererDigest:     \"orderer22digest\"|OrdererDigest:     \"${ordererDigest22}\"|g" temp.go
sed -i.bak "s|ordererDigest: orderer22digest|ordererDigest: ${ordererDigest22}|g" temp.yaml
ordererTag22="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-orderer:2.2 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "ordererTag22 is $ordererTag22"
# OrdererTag:        "orderer22tag"
sed -i.bak "s|OrdererTag:        \"orderer22tag\"|OrdererTag:        \"${ordererTag22}\"|g" temp.go
sed -i.bak "s|ordererTag: orderer22tag|ordererTag: ${ordererTag22}|g" temp.yaml

### ORDERER 2.5.x
ordererDigest25=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-orderer:2.5 | awk -F"@" '{print $2}')
echo "ordererDigest25 is $ordererDigest25"
# OrdererDigest:     "orderer25digest"
sed -i.bak "s|OrdererDigest:     \"orderer25digest\"|OrdererDigest:     \"${ordererDigest25}\"|g" temp.go
sed -i.bak "s|ordererDigest: orderer25digest|ordererDigest: ${ordererDigest25}|g" temp.yaml
ordererTag25="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-orderer:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "ordererTag25 is $ordererTag25"
# OrdererTag:        "orderer25tag"
sed -i.bak "s|OrdererTag:        \"orderer25tag\"|OrdererTag:        \"${ordererTag25}\"|g" temp.go
sed -i.bak "s|ordererTag: orderer25tag|ordererTag: ${ordererTag25}|g" temp.yaml

enrollerDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-enroller | awk -F"@" '{print $2}')
echo "enrollerDigest is $enrollerDigest"
# EnrollerDigest:      ""
sed -i.bak "s|EnrollerDigest: .*$|EnrollerDigest: \"${enrollerDigest}\",|g" temp.go
sed -i.bak "s|enrollerDigest: .*$|enrollerDigest: ${enrollerDigest}|g" temp.yaml
enrollerTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-enroller | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
echo "enrollerTag is $enrollerTag"
# EnrollerTag:      ""
sed -i.bak "s|EnrollerTag: .*$|EnrollerTag: \"${enrollerTag}\",|g" temp.go
sed -i.bak "s|enrollerTag: .*$|enrollerTag: ${enrollerTag}|g" temp.yaml

### Disable fabric 1.4.12 from configs
### Adding all 1.4.x related tags/digests here for IBP ####
# if [[ ${PRODUCT} = "ibp" ]]; then
#     ordererDigest14=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-orderer:1.4 | awk -F"@" '{print $2}')
#     echo "ordererDigest14 is $ordererDigest14"
#     # OrdererDigest:        "orderer14digest"
#     sed -i.bak "s|OrdererDigest:     \"orderer14digest\"|OrdererDigest:     \"${ordererDigest14}\"|g" temp.go
#     sed -i.bak "s|ordererDigest: orderer14digest|ordererDigest: ${ordererDigest14}|g" temp.yaml
#     ordererTag14="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-orderer:1.4 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
#     echo "ordererTag14 is $ordererTag14"
#     # OrdererTag:        "orderer14tag"
#     sed -i.bak "s|OrdererTag:        \"orderer14tag\"|OrdererTag:        \"${ordererTag14}\"|g" temp.go
#     sed -i.bak "s|ordererTag: orderer14tag|ordererTag: ${ordererTag14}|g" temp.yaml

#     peerDigest14=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-peer:1.4 | awk -F"@" '{print $2}')
#     echo "peerDigest14 is $peerDigest14"
#     # PeerDigest:     "peer14digest"
#     sed -i.bak "s|PeerDigest:     \"peer14digest\"|PeerDigest:     \"${peerDigest14}\"|g" temp.go
#     sed -i.bak "s|peerDigest: peer14digest|peerDigest: ${peerDigest14}|g" temp.yaml
#     peerTag14="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-peer:1.4 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
#     echo "peerTag14 is $peerTag14"
#     # PeerTag:          "peer14tag"
#     sed -i.bak "s|PeerTag:        \"peer14tag\"|PeerTag: \"${peerTag14}\"|g" temp.go
#     sed -i.bak "s|peerTag: peer14tag|peerTag: ${peerTag14}|g" temp.yaml

#     dindDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-dind | awk -F"@" '{print $2}')
#     echo "dindDigest is $dindDigest"
#     # DindDigest:       ""
#     sed -i.bak "s|DindDigest: .*$|DindDigest: \"${dindDigest}\",|g" temp.go
#     sed -i.bak "s|dindDigest: .*$|dindDigest: ${dindDigest}|g" temp.yaml
#     dindTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-dind | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
#     echo "dindTag is $dindTag"
#     # DindTag:       ""
#     sed -i.bak "s|DindTag: .*$|DindTag:        \"${dindTag}\",|g" temp.go
#     sed -i.bak "s|dindTag: .*$|dindTag: ${dindTag}|g" temp.yaml

#     couchdb231digest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-couchdb:2.3.1 | awk -F"@" '{print $2}')
#     echo "couchdb231digest is $couchdb231digest"
#     # couchdbDigest:
#     sed -i.bak "s|CouchDBDigest:  \"couchdb231digest\"|CouchDBDigest:    \"${couchdb231digest}\"|g" temp.go
#     sed -i.bak "s|couchdbDigest: couchdb231digest|couchdbDigest: ${couchdb231digest}|g" temp.yaml
#     couchdb231tag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-couchdb:2.3.1 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
#     echo "couchdTag231 is $couchdb231tag"
#     # couchdbTag:
#     sed -i.bak "s|CouchDBTag:     \"couchdb231tag\"|CouchDBTag: \"${couchdb231tag}\"|g" temp.go
#     sed -i.bak "s|couchdbTag: couchdb231tag|couchdbTag: ${couchdb231tag}|g" temp.yaml

#     fluentdTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-fluentd | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
#     echo "fluentdTag is $fluentdTag"
#     # FluentdTag:    ""
#     sed -i.bak "s|FluentdTag: .*$|FluentdTag: \"${fluentdTag}\",|g" temp.go
#     sed -i.bak "s|fluentdTag: .*$|fluentdTag: ${fluentdTag}|g" temp.yaml
#     fluentdDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-fluentd | awk -F"@" '{print $2}')
#     echo "fluentdDigest is $fluentdDigest"
#     # FluentdTag:    ""
#     sed -i.bak "s|FluentdDigest: .*$|FluentdDigest: \"${fluentdDigest}\",|g" temp.go
#     sed -i.bak "s|fluentdDigest: .*$|fluentdDigest: ${fluentdDigest}|g" temp.yaml
# fi

sed -i.bak "s/REGISTRY_NAMESPACE-/${REGISTRY_NS}-/g" temp.go
mv temp.go ../../operatorconfig/versions.go

## replace registry namespace with the correct values
sed -i.bak "s/REGISTRY_NAMESPACE-/${REGISTRY_NS}-/g" temp.yaml
mv temp.yaml ../../definitions/console/deployer-configmap.yaml

###### console images
cp console-template.txt temp.go

initDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-init | awk -F"@" '{print $2}')
echo "initDigest is $initDigest"
sed -i.bak "s|images.ConsoleInitDigest =.*|images.ConsoleInitDigest = \"${initDigest}\"|g" temp.go
if [[ ${PRODUCT} = "ibp" ]]; then
    initTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-init | awk '{print $1}' | awk -F":" '{print $2}')
else
    initTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-init | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "initTag is $initTag"
sed -i.bak "s|images.ConsoleInitTag =.*|images.ConsoleInitTag = \"${initTag}\"|g" temp.go

publicConsoleDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-console | awk -F"@" '{print $2}')
echo "publicConsoleDigest is $publicConsoleDigest"
sed -i.bak "s|publicConsoleDigest   =.*|publicConsoleDigest   = \"${publicConsoleDigest}\"|g" temp.go
if [[ ${PRODUCT} = "ibp" ]]; then
    publicConsoleTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-console | awk '{print $1}' | awk -F":" '{print $2}')
else
    publicConsoleTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-console | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "publicConsoleTag is $publicConsoleTag"
sed -i.bak "s|publicConsoleTag      =.*|publicConsoleTag      = \"${publicConsoleTag}\"|g" temp.go

#TODO: image name for internal console ?
internalConsoleDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-console | awk -F"@" '{print $2}')
echo "internalConsoleDigest is $internalConsoleDigest"
sed -i.bak "s|internalConsoleDigest   =.*|internalConsoleDigest   = \"${internalConsoleDigest}\"|g" temp.go
if [[ ${PRODUCT} = "ibp" ]]; then
    internalConsoleTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-console | awk '{print $1}' | awk -F":" '{print $2}')
else
    internalConsoleTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-console | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "internalConsoleTag is $internalConsoleTag"
sed -i.bak "s|internalConsoleTag      =.*|internalConsoleTag      = \"${internalConsoleTag}\"|g" temp.go

sed -i.bak "s|images.CouchDBDigest =.*|images.CouchDBDigest = \"${couchdbDigest312}\"|g" temp.go
if [[ ${PRODUCT} = "ibp" ]]; then
    couchdbTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-couchdb:3.3.3 | awk '{print $1}' | awk -F":" '{print $2}')
else
    couchdbTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-couchdb:3.3.3 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "couchdbTag is $couchdbTag"
sed -i.bak "s|images.CouchDBTag =.*|images.CouchDBTag = \"${couchdbTag}\"|g" temp.go

configtxlatorDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-utilities:2.5 | awk -F"@" '{print $2}')
echo "configtxlatorDigest is $configtxlatorDigest"
sed -i.bak "s|images.ConfigtxlatorDigest =.*|images.ConfigtxlatorDigest = \"${configtxlatorDigest}\"|g" temp.go
if [[ ${PRODUCT} = "ibp" ]]; then
    configtxlatorTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-utilities:2.5 | awk '{print $1}' | awk -F":" '{print $2}')
else
    configtxlatorTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-utilities:2.5 | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "configtxlatorTag is $configtxlatorTag"
sed -i.bak "s|images.ConfigtxlatorTag =.*|images.ConfigtxlatorTag = \"${configtxlatorTag}\"|g" temp.go

deployerDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-deployer | awk -F"@" '{print $2}')
echo "deployerDigest is $deployerDigest"
sed -i.bak "s|images.DeployerDigest =.*|images.DeployerDigest = \"${deployerDigest}\"|g" temp.go
if [[ ${PRODUCT} = "ibp" ]]; then
    deployerTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-deployer | awk '{print $1}' | awk -F":" '{print $2}')
else
    deployerTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-deployer | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "deployerTag is $deployerTag"
sed -i.bak "s|images.DeployerTag =.*|images.DeployerTag = \"${deployerTag}\"|g" temp.go

mustgatherDigest=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-mustgather | awk -F"@" '{print $2}')
echo "mustgatherDigest is $mustgatherDigest"
sed -i.bak "s|images.MustgatherDigest =.*|images.MustgatherDigest = \"${mustgatherDigest}\"|g" temp.go

if [[ ${PRODUCT} = "ibp" ]]; then
    mustgatherTag=$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-mustgather | awk '{print $1}' | awk -F":" '{print $2}')
else
    mustgatherTag="$(cat ${DIGESTS_FILE} | grep us.icr.io/${REGISTRY_NS}-temp/${REGISTRY_NS}-mustgather | awk '{print $1}' | awk -F":" '{print $2}')-${ARCH}"
fi
echo "mustgatherTag is $mustgatherTag"
sed -i.bak "s|images.MustgatherTag =.*|images.MustgatherTag = \"${mustgatherTag}\"|g" temp.go

oldmustgatherTag=$(grep -E "\-[0-9]{8}-amd64" ../../pkg/offering/base/console/override/deployercm_test.go | awk -F '"' '{print $2}')
if [[ ${PRODUCT} = "support" ]]; then
    sed -i.bak "s/ibp-mustgather/${REGISTRY_NS}-mustgather/g" ../../pkg/offering/base/console/override/deployercm_test.go
elif [[ ${PRODUCT} = "ibp" ]]; then
    sed -i.bak "s/ibm-hlfsupport-mustgather/${REGISTRY_NS}-mustgather/g" ../../pkg/offering/base/console/override/deployercm_test.go
fi
sed -i.bak "s/${oldmustgatherTag}/${mustgatherTag}-amd64/g" ../../pkg/offering/base/console/override/deployercm_test.go

## replace registry namespace with the correct values
sed -i.bak "s/REGISTRY_NAMESPACE-/${REGISTRY_NS}-/g" temp.go
mv temp.go ../../defaultconfig/console/console.go

## remove all backup files generated with sed command
rm -rf *.bak

## Format go files
cd ../../
goimports -w ./operatorconfig/versions.go ./defaultconfig/console/console.go