#! /bin/bash -e

#*******************************************************************************
# IBM Confidential
# OCO Source Materials
# 5900-AM9
# (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
# The source code for this program is not  published or otherwise divested of
# its trade secrets, irrespective of what has been deposited with
# the U.S. Copyright Office.
#*******************************************************************************

OPERATOR_BASE=${PWD}/../
export ARCH=${ARCH}
## replace product version with 1.0.0
sed -i.bak "s|	Operator =.*$|	Operator = \"1.0.0\"|g" ${OPERATOR_BASE}/version/version.go

cd product-offerings/support && ./generate-support-artifacts.sh && cd -
cp builds/Dockerfile.support $OPERATOR_BASE/Dockerfile
cp Readme/README-support.md $OPERATOR_BASE/README.md
cd images/ && ./update_script.sh digests-support.txt ${PRODUCT} && cd -
cd images/ && ./update_csv_images.sh digests-support.txt ${PRODUCT} && cd -

OLD_STRING="projectName: fabric-opensource-operator"
NEW_STRING="projectName: ibm-hlfsupport"
sed -i.bak "s|${OLD_STRING}|${NEW_STRING}|g" ${OPERATOR_BASE}/PROJECT

OLD_STRING='csv-path: "config/manifests/bases/fabric-opensource-operator.clusterserviceversion.yaml"'
NEW_STRING='csv-path: "config/manifests/bases/ibm-hlfsupport.clusterserviceversion.yaml"'
sed -i.bak "s|${OLD_STRING}|${NEW_STRING}|g" ${OPERATOR_BASE}/config/scorecard/.osdk-scorecard.yaml
