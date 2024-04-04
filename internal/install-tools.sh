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

cd /tmp
go install golang.org/x/tools/cmd/goimports@latest
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv kustomize /usr/local/bin
go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.8.0
cd -

## getOperatorSDK
sudo rm /usr/local/bin/operator-sdk || true

OPERATOR_SDK_VERSION="v1.24.1"
ARCH=$(go env GOARCH)
OS=$(go env GOOS)
URL="https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}/operator-sdk_${OS}_${ARCH}"

echo "Installing operator-sdk version ${OPERATOR_SDK_VERSION} to /usr/local/bin/operator-sdk"
curl -sL $URL > operator-sdk
chmod +x operator-sdk
sudo mv operator-sdk /usr/local/bin
operator-sdk version