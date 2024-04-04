# Changes required for internal build

## Getlabels

Set `OPERATOR_LABEL_PREFIX` env var in dockerfile.
ibp - `OPERATOR_LABEL_PREFIX=ibp`
ibm-hlfsupport - `OPERATOR_LABEL_PREFIX=ibm-hlfsupport`

## Labels in auto generated manifests and bundles

Change `commonLabels` in `config/default/kustomization.yaml` file and run `make manifests bundle`

## Annotations

Add the productid related annotations to `config/manager/kustomization.yaml`

```yaml
commonAnnotations:
  productID: 5d5997a033594f149a534a09802d60f1
  productMetric: VIRTUAL_PROCESSOR_CORE
  productName: IBM Support for Hyperledger Fabric
  productVersion: "1.0.0"

```

Add annotations to definitions/ca/deployment.yaml, definitions/orderer/deployment.yaml, definitions/peer/deployment.yaml, definitions/console/deployment.yaml

Check `envsubst`
