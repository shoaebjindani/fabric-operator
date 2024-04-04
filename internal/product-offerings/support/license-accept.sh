#! /bin/bash

#*******************************************************************************
# IBM Confidential
# OCO Source Materials
# 5900-AM9
# (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
# The source code for this program is not  published or otherwise divested of
# its trade secrets, irrespective of what has been deposited with
# the U.S. Copyright Office.
#*******************************************************************************

COMMON_STRUCT_FILEPATH="${PWD}/../../../api/v1beta1/common_struct.go"

OLD_STRING="Accept should be set to true to accept the license."
NEW_STRING="Accept should be set to true to accept the license. https://ibm.biz/ibm-hlfsupport-rhm-license"
sed -i.bak "s|${OLD_STRING}|${NEW_STRING}|g" $COMMON_STRUCT_FILEPATH
rm $COMMON_STRUCT_FILEPATH.bak

CONSOLE_TYPES_FILEPATH="${PWD}/../../../api/v1beta1/ibpconsole_types.go"
OLD_STRING="The Console is used to deploy and manage the CA, peer, ordering nodes."
NEW_STRING="The Console is used to deploy and manage the CA, peer, ordering nodes. \n// Documentation For additional details regarding install parameters check: https://ibm.biz/ibm-hlfsupport-rhm-readme. \n// By installing this product you accept the license terms https://ibm.biz/ibm-hlfsupport-rhm-license."
sed -i.bak "s|${OLD_STRING}|${NEW_STRING}|g" $CONSOLE_TYPES_FILEPATH
rm $CONSOLE_TYPES_FILEPATH.bak
