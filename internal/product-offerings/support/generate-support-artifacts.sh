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


OPERATOR_BASE_DIR="${PWD}/../../../"

echo "copying manager-kustomization.yaml to config/manager/kustomization.yaml"
cp manager-kustomization.yaml ${OPERATOR_BASE_DIR}/config/manager/kustomization.yaml

echo "copying ca-kustomization.yaml to definitions/ca/kustomization.yaml"
cp ca-kustomization.yaml ${OPERATOR_BASE_DIR}/definitions/ca/kustomization.yaml
kustomize build ${OPERATOR_BASE_DIR}/definitions/ca --output ${OPERATOR_BASE_DIR}/definitions/ca/deployment.yaml
rm ${OPERATOR_BASE_DIR}/definitions/ca/kustomization.yaml

echo "copying console-kustomization.yaml to definitions/console/kustomization.yaml"
cp console-kustomization.yaml ${OPERATOR_BASE_DIR}/definitions/console/kustomization.yaml
kustomize build ${OPERATOR_BASE_DIR}/definitions/console --output ${OPERATOR_BASE_DIR}/definitions/console/deployment.yaml
rm ${OPERATOR_BASE_DIR}/definitions/console/kustomization.yaml

echo "copying orderer-kustomization.yaml to definitions/orderer/kustomization.yaml"
cp orderer-kustomization.yaml ${OPERATOR_BASE_DIR}/definitions/orderer/kustomization.yaml
kustomize build ${OPERATOR_BASE_DIR}/definitions/orderer --output ${OPERATOR_BASE_DIR}/definitions/orderer/deployment.yaml
rm ${OPERATOR_BASE_DIR}/definitions/orderer/kustomization.yaml

echo "copying peer-kustomization.yaml to definitions/peer/kustomization.yaml"
cp peer-kustomization.yaml ${OPERATOR_BASE_DIR}/definitions/peer/kustomization.yaml
kustomize build ${OPERATOR_BASE_DIR}/definitions/peer --output ${OPERATOR_BASE_DIR}/definitions/peer/deployment.yaml
rm ${OPERATOR_BASE_DIR}/definitions/peer/kustomization.yaml

echo "copying default-kustomization.yaml to definitions/default/kustomization.yaml"
cp default-kustomization.yaml ${OPERATOR_BASE_DIR}/config/default/kustomization.yaml

./license-accept.sh
# cd $OPERATOR_BASE_DIR
# make manifests bundle
# cd -
