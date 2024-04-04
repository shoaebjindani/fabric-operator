#!/bin/bash -e

#*******************************************************************************
# IBM Confidential
# OCO Source Materials
# 5900-AM9
# (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
# The source code for this program is not  published or otherwise divested of
# its trade secrets, irrespective of what has been deposited with
# the U.S. Copyright Office.
#*******************************************************************************

DIGESTS_FILE=$1
OPERATOR_BASE=${PWD}/../..

if [[ ! -f "$DIGESTS_FILE" ]]; then
    echo "file $DIGESTS_FILE not found"
    echo "usage: ./update_csv_images.sh <digest-file-name>"
    exit 0
fi

if [[ ${PRODUCT} = "support" ]]; then
    REGISTRY_NS="ibm-hlfsupport"
    PRODUCT_NAME="ibm-hlfsupport"
    PROD_VERSION="1.0.0"
    OLD_CSV_FILE="ibm-hlfsupport.clusterserviceversion.yaml"
elif [[ ${PRODUCT} = "ibp" ]]; then
    REGISTRY_NS="ibp"
    PRODUCT_NAME="ibm-blockchain"
    PROD_VERSION="2.5.4"
    OLD_CSV_FILE="ibm-blockchain.clusterserviceversion.yaml"
else
    echo "INVALID PRODUCT. It can be either support or ibp, exiting ..."
    exit 0
fi

rm -f clusterserviceversion.yaml
cp $OLD_CSV_FILE clusterserviceversion.yaml 
cp relatedImages-template.yaml temp.yaml

# Init
initDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-init | awk '{print $3}')
echo "init digest is $initDigest"
sed -i.bak "s|image: initDigest|image: ${initDigest}|g" temp.yaml

# crdwebhook
crdwebhookDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-crdwebhook | awk '{print $3}')
echo "crdwebhook digest is $crdwebhookDigest"
sed -i.bak "s|image: crdwebhookDigest|image: ${crdwebhookDigest}|g" temp.yaml

# console
consoleDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-console | awk '{print $3}')
echo "Console digest is $consoleDigest"
sed -i.bak "s|image: consoleDigest|image: ${consoleDigest}|g" temp.yaml

# deployer
deployerDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-deployer | awk '{print $3}')
echo "Deployer digest is $deployerDigest"
sed -i.bak "s|image: deployerDigest|image: ${deployerDigest}|g" temp.yaml

# utilities
utilitiesDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-utilities:2.4 | awk '{print $3}')
echo "Utilities digest is $utilitiesDigest"
sed -i.bak "s|image: utilitiesDigest|image: ${utilitiesDigest}|g" temp.yaml

# CA
caDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-ca | awk '{print $3}')
echo "CA digest is $caDigest"
sed -i.bak "s|image: caDigest|image: ${caDigest}|g" temp.yaml

# Peer 2.2.x
peer22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-peer:2.2 | awk '{print $3}')
echo "Peer 2.2.x digest is $peer22Digest"
sed -i.bak "s|image: peer22Digest|image: ${peer22Digest}|g" temp.yaml

# Peer 2.4.x
peer24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-peer:2.4 | awk '{print $3}')
echo "Peer 2.4.x digest is $peer24Digest"
sed -i.bak "s|image: peer24Digest|image: ${peer24Digest}|g" temp.yaml

# Peer 2.5.x
peer25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-peer:2.5 | awk '{print $3}')
echo "Peer 2.5.x digest is $peer25Digest"
sed -i.bak "s|image: peer25Digest|image: ${peer25Digest}|g" temp.yaml

# Orderer 2.2.x
orderer22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-orderer:2.2 | awk '{print $3}')
echo "Orderer 2.2.x digest is $orderer22Digest"
sed -i.bak "s|image: orderer22Digest|image: ${orderer22Digest}|g" temp.yaml

# Orderer 2.4.x
orderer24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-orderer:2.4 | awk '{print $3}')
echo "Orderer 2.4.x digest is $orderer24Digest"
sed -i.bak "s|image: orderer24Digest|image: ${orderer24Digest}|g" temp.yaml

# Orderer 2.5.x
orderer25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-orderer:2.5 | awk '{print $3}')
echo "Orderer 2.5.x digest is $orderer25Digest"
sed -i.bak "s|image: orderer25Digest|image: ${orderer25Digest}|g" temp.yaml

# GrpcWeb
grpcDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-grpcweb | awk '{print $3}')
echo "gRPCWeb digest is $grpcDigest"
sed -i.bak "s|image: grpcwebDigest|image: ${grpcDigest}|g" temp.yaml

# enroller
enrollerDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-enroller | awk '{print $3}')
echo "Enroller igest is $enrollerDigest"
sed -i.bak "s|image: enrollerDigest|image: ${enrollerDigest}|g" temp.yaml

# couchdb v3
couchdbv3Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-couchdb:3.3.3 | awk '{print $3}')
echo "couchdb v3 digest is $couchdbv3Digest"
sed -i.bak "s|image: couchdbv3Digest|image: ${couchdbv3Digest}|g" temp.yaml

# ccenv 2.2.x
ccenv22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-ccenv:2.2 | awk '{print $3}')
echo "ccenv digest is $ccenv22Digest"
sed -i.bak "s|image: ccenv22Digest|image: ${ccenv22Digest}|g" temp.yaml

# ccenv 2.4.x
ccenv24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-ccenv:2.4 | awk '{print $3}')
echo "ccenv digest is $ccenv24Digest"
sed -i.bak "s|image: ccenv24Digest|image: ${ccenv24Digest}|g" temp.yaml

# ccenv 2.5.x
ccenv25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-ccenv:2.5 | awk '{print $3}')
echo "ccenv digest is $ccenv25Digest"
sed -i.bak "s|image: ccenv25Digest|image: ${ccenv25Digest}|g" temp.yaml

# goenv 2.2.x
goenv22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-goenv:2.2 | awk '{print $3}')
echo "goenv digest is $goenv22Digest"
sed -i.bak "s|image: goenv22Digest|image: ${goenv22Digest}|g" temp.yaml

# goenv 2.4.x
goenv24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-goenv:2.4 | awk '{print $3}')
echo "goenv digest is $goenv24Digest"
sed -i.bak "s|image: goenv24Digest|image: ${goenv24Digest}|g" temp.yaml

# goenv 2.5.x
goenv25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-goenv:2.5 | awk '{print $3}')
echo "goenv digest is $goenv25Digest"
sed -i.bak "s|image: goenv25Digest|image: ${goenv25Digest}|g" temp.yaml

# javaenv 2.2.x
javaenv22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-javaenv:2.2 | awk '{print $3}')
echo "javaenv digest is $javaenv22Digest"
sed -i.bak "s|image: javaenv22Digest|image: ${javaenv22Digest}|g" temp.yaml

# javaenv 2.4.x
javaenv24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-javaenv:2.4 | awk '{print $3}')
echo "javaenv digest is $javaenv24Digest"
sed -i.bak "s|image: javaenv24Digest|image: ${javaenv24Digest}|g" temp.yaml

# javaenv 2.5.x
javaenv25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-javaenv:2.5 | awk '{print $3}')
echo "javaenv digest is $javaenv25Digest"
sed -i.bak "s|image: javaenv25Digest|image: ${javaenv25Digest}|g" temp.yaml

# nodeenv 2.2.x
nodeenv22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-nodeenv:2.2 | awk '{print $3}')
echo "nodeenv Digest is $nodeenv22Digest"
sed -i.bak "s|image: nodeenv22Digest|image: ${nodeenv22Digest}|g" temp.yaml

# nodeenv 2.4.x
nodeenv24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-nodeenv:2.4 | awk '{print $3}')
echo "nodeenv Digest is $nodeenv24Digest"
sed -i.bak "s|image: nodeenv24Digest|image: ${nodeenv24Digest}|g" temp.yaml

# nodeenv 2.5.x
nodeenv25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-nodeenv:2.5 | awk '{print $3}')
echo "nodeenv Digest is $nodeenv25Digest"
sed -i.bak "s|image: nodeenv25Digest|image: ${nodeenv25Digest}|g" temp.yaml

# chaincode-launcher 2.2.x
chaincodeLauncher22Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-chaincode-launcher:2.2 | awk '{print $3}')
echo "chaincodeLauncher22Digest is $chaincodeLauncher22Digest"
sed -i.bak "s|image: chaincodeLauncher22Digest|image: ${chaincodeLauncher22Digest}|g" temp.yaml

# chaincode-launcher 2.4.x
chaincodeLauncher24Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-chaincode-launcher:2.4 | awk '{print $3}')
echo "chaincodeLauncher24Digest is $chaincodeLauncher24Digest"
sed -i.bak "s|image: chaincodeLauncher24Digest|image: ${chaincodeLauncher24Digest}|g" temp.yaml

# chaincode-launcher 2.5.x
chaincodeLauncher25Digest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-chaincode-launcher:2.5 | awk '{print $3}')
echo "chaincodeLauncher25Digest is $chaincodeLauncher25Digest"
sed -i.bak "s|image: chaincodeLauncher25Digest|image: ${chaincodeLauncher25Digest}|g" temp.yaml

# mustgather
mustgatherDigest=$(cat ${DIGESTS_FILE} | grep cp.stg.icr.io/cp/${REGISTRY_NS}-mustgather | awk '{print $3}')
echo "mustgatherDigest is $mustgatherDigest"
sed -i.bak "s|image: mustgatherDigest|image: ${mustgatherDigest}|g" temp.yaml

cat temp.yaml >> clusterserviceversion.yaml
sed -i.bak "s/cp.stg.icr.io/cp.icr.io/g" clusterserviceversion.yaml
rm temp.yaml

# delete the opensource csv
echo "deleting old csv files"
rm -rf ${OPERATOR_BASE}/bundle/manifests/fabric-opensource-operator.clusterserviceversion.yaml
rm -rf ${OPERATOR_BASE}/config/manifests/bases/fabric-opensource-operator.clusterserviceversion.yaml

# copy the internal product csv
echo "copying over the new csv files"
cp clusterserviceversion.yaml ${OPERATOR_BASE}/bundle/manifests/${PRODUCT_NAME}.clusterserviceversion.yaml
mv clusterserviceversion.yaml ${OPERATOR_BASE}/config/manifests/bases/${PRODUCT_NAME}.clusterserviceversion.yaml

# copy kustomize yaml with the right value
cp kustomize-config-manifests.yaml kustomization.yaml
sed -i.bak "s|PRODUCTNAME|${PRODUCT_NAME}|g" kustomization.yaml
mv kustomization.yaml ${OPERATOR_BASE}/config/manifests/kustomization.yaml

# delete bak files
rm *.bak
