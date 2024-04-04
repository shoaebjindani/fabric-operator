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

RELEASE=$(curl -s -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/securego/gosec/releases/latest | jq -r .tag_name)

echo "Latest Gosec release determined to be $RELEASE... Installing..."

curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b $(go env GOPATH)/bin $RELEASE

## TODO: Disable until this false positive is corrected in gosec tool
## G402 (CWE-295): TLS MinVersion too low.
gosec -exclude=G402 ./...