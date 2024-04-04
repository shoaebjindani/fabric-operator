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

function getKubectl {
    if ! kubectl_loc="$(type -p "kubectl")" || [[ -z $kubectl_loc ]]; then
        echo "Get kubectl"
        curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.13.2/bin/linux/amd64/kubectl
        chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl
    fi
}

getKubectl
