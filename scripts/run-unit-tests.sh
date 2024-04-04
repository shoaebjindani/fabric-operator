#!/bin/bash
#*******************************************************************************
# IBM Confidential
# OCO Source Materials
# 5900-AM9
# (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
# The source code for this program is not  published or otherwise divested of
# its trade secrets, irrespective of what has been deposited with
# the U.S. Copyright Office.
#*******************************************************************************

echo "Running unit tests..."

export PATH=$PATH:$GOPATH/bin

# List of packages to not run test for
EXCLUDED_PKGS=(
    "/mocks"
    "/manager$"
    "/manager/resources$"
    "/apis"
    "/controller$"
    "/controllers$"
    "ibp-operator/config$"
    "/integration"
)

PKGS=`go list ./... | grep -v -f <(printf '%s\n' "${EXCLUDED_PKGS[@]}")`

go test $PKGS -cover
exit $?
