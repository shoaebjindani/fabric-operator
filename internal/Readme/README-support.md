# Introduction

IBM Support for Hyperledger Fabric 1.0.0 includes a management console for deploying and managing nodes in a blockchain network. A set of blockchain APIs is also available for node deployment and management from the command line. The IBM Support for Hyperledger Fabric components are based on Hyperledger Fabric v2.2.5.

The information in this README is intended to be used as a quick set of steps for deploying and running the operator. For a more comprehensive set of instructions that include the deployment flow and how to build a blockchain network see the instructions in the [IBM Support for Hyperledger Fabric 1.0.0 documentation](https://cloud.ibm.com/docs/hlf-support?topic=hlf-support-get-started-console-ocp).

## Details

You can install the operator and then run it to deploy the IBM Support for Hyperledger Fabric console UI that is used to deploy Certificate Authority (CA), orderer, and peer nodes that are based on Hyperledger Fabric v2.2.5. After you run the operator to deploy the console UI, see the [Build a network tutorial](https://cloud.ibm.com/docs/hlf-support?topic=hlf-support-ibm-hlfsupport-console-build-network) to easily get started building a blockchain network.

## Prerequisites

1. IBM Support for Hyperledger Fabric can be installed only on the [OpenShift Container Platform](https://docs.openshift.com) 4.6, 4.7, and 4.8.

2. You need to install and connect to your cluster by using [OpenShift Container Platform CLI](https://docs.openshift.com/container-platform/4.8/cli_reference/openshift_cli/getting-started-cli.html) to deploy the platform.

3. You need to purchase IBM Support for Hyperledger Fabric and obtain your entitlement from [My IBM dashboard](https://myibm.ibm.com/dashboard/). Your entitlement includes your entitlement key that is required to deploy the Docker images.

4. It is required that you create a new OpenShift project for each blockchain network that you deploy with IBM Support for Hyperledger Fabric. For example, if you plan to create different networks for development, staging, and production, then you need to create a unique project for each environment. Each project creates a new Kubernetes namespace. Using a separate namespace provides each network with separate resources and allows you to set unique access policies for each network. You need to follow these deployment instructions to deploy a separate operator and console for each project. Only one console can be deployed to a project at a time.
<!-- 5. A 30 day free trial is available from the [Red Hat Marketplace](https://marketplace.redhat.com/en-us/products/ibm-blockchain #TODO: update link and update item number). -->

5. Review the storage requirements for your PVC in the **Storage** section of this README.

## Prereq scripts - How to locate

In addition to a custom Security Context Constraint, IBM Support for Hyperledger Fabric 1.0.0 requires that a custom clusterRole and clusterRoleBinding be applied to your OpenShift project. These files are also available in the `./inventory/ibmHLFSupportOperatorSetup/files/` folder.

You can find instructions on how to apply those policies to your namespace by using the [Deploying the IBM Support for Hyperledger Fabric Operator](./inventory/ibmHLFSupportOperatorSetup/README.md) README.

### Resources Required

Ensure that your OpenShift cluster has sufficient resources for the IBM Support for Hyperledger Fabric console and for the blockchain nodes that you create. The amount of resources that are required can vary depending on your infrastructure, network design, and performance requirements. To help you plan your resource requirements, the default CPU, memory, and storage requirements for each component type are provided in this table. Your actual resource allocations are visible in your blockchain console when you deploy a node and can be adjusted at deployment time or after deployment according to your business needs.

| **Component** (all containers)     | CPU\*\* | Memory (GB) | Storage (GB)                                               |
| ---------------------------------- | ------- | ----------- | ---------------------------------------------------------- |
| **Peer (Hyperledger Fabric v1.4)** | 1.1     | 2.8         | 200 (includes 100GB for peer and 100GB for state database) |
| **Peer (Hyperledger Fabric v2.x)** | 0.7     | 2.0         | 200 (includes 100GB for peer and 100GB for state database) |
| **CA**                             | 0.1     | 0.2         | 20                                                         |
| **Ordering node**                  | 0.35    | 0.7         | 100                                                        |
| **Operator**                       | 0.1     | 0.2         | 0                                                          |
| **Console**                        | 1.2     | 2.4         | 10                                                         |
| **Webhook**                        | 0.1     | 0.2         | 0                                                          |

\*\* These values can vary slightly. Actual VPC allocations are visible in the blockchain console when a node is deployed.

### Red Hat OpenShift SecurityContextConstraints Requirements

The IBM Support for Hyperledger Fabric 1.0.0 requires a custom Security Context Constraint to be applied to your OpenShift project.

You can find instructions on how to apply those policies to your namespace by using the [Deploying the IBM Support for Hyperledger Fabric Operator](./inventory/ibmHLFSupportOperatorSetup/README.md) README.

Custom SecurityContextConstraints definition:

```
allowHostDirVolumePlugin: false
allowHostIPC: false
allowHostNetwork: false
allowHostPID: false
allowHostPorts: false
allowPrivilegeEscalation: false
allowPrivilegedContainer: false
allowedCapabilities:
- NET_BIND_SERVICE
- CHOWN
- DAC_OVERRIDE
- SETGID
- SETUID
- FOWNER
apiVersion: security.openshift.io/v1
defaultAddCapabilities: []
fsGroup:
  type: RunAsAny
kind: SecurityContextConstraints
metadata:
  name: REPLACE_NAMESPACE
readOnlyRootFilesystem: false
requiredDropCapabilities: []
runAsUser:
  type: RunAsAny
seLinuxContext:
  type: RunAsAny
supplementalGroups:
  type: RunAsAny
volumes:
- "*"
```

## Installing the CASE

See the following README files for instructions on how to deploy the IBM Support for Hyperledger Fabric Operator and Console:

- [Deploying the IBM Support for Hyperledger Fabric Operator](./inventory/ibmHLFSupportOperatorSetup/README.md)
- [Deploying the IBM Support for Hyperledger Fabric Console](./inventory/ibmHLFSupportConsole/README.md)

### Configuration

### Operator

| **Parameter**    | Description                                                     | Default value  | Required |
| ---------------- | --------------------------------------------------------------- | -------------- | -------- |
| imagePullSecrets | Name of the Kubernetes secret that contains the entitlement key | cp-pull-secret | Yes      |

### Console

| **Parameter** | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Default value | Required |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | -------- |
| email         | Email address of the console administrator.                                                                                                                                                                                                                                                                                                                                                                                                                      | none provided | Yes      |
| password      | Initial password ibmHLFSupportOperatorSetup the console administrator.                                                                                                                                                                                                                                                                                                                                                                                           | none provided | Yes      |
| domain        | Name of your Kubernetes cluster domain. You can find this value by using the OpenShift web console. Use the dropdown menu next to **OpenShift Container Platform** at the top of the page to switch from **Service Catalog** to **Cluster Console**. Examine the url for that page. It will be similar to `console.xyz.abc.com/k8s/cluster/projects`. The value of the domain then would be `xyz.abc.com`, after removing `console` and `/k8s/cluster/projects`. | none provided | Yes      |

## Storage

IBM Support for Hyperledger Fabric requires persistent storage for each CA, peer, and ordering node that you deploy, in addition to the console and platform tooling. The IBM Support for Hyperledger Fabric console uses [dynamic provisioning](https://docs.openshift.com/container-platform/4.8/storage/dynamic-provisioning.html) to allocate storage for each blockchain node that you deploy. Before you use the console or the APIs to deploy any node, you have the opportunity to choose your persistent storage from the available persistent storage options in OpenShift Container Platform. Create a storage class with a sufficient amount of backing storage for your IBM Support for Hyperledger Fabric network and the nodes that you create. You can set this storage class to the default storage class of your Kubernetes cluster, or specify this class when you deploy the IBM Support for Hyperledger Fabric console. If you are using a multi-zone cluster in OCP, then you must configure the default storage class for each zone. After you create the storage class, run the command `kubectl patch storageclass` to set the storage class of the multizone region to be the default storage class.

**Note:** If you prefer not to choose a persistent storage option, the default storage class of your Kubernetes cluster is used.

# Limitations

Before you begin, ensure that you understand the following limitations:

- IBM Support for Hyperledger Fabric 1.0.0 is only supported on Red Hat OpenShift 4.6, 4.7, and 4.8.
- The offering does not include an entitlement to OpenShift.
- You are responsible for the management of health monitoring, security, logging, and resource usage of your blockchain components.
- The console creates nodes based on the Hyperledger Fabric v2.2.5 node images.
- You can only deploy one IBM Support for Hyperledger Fabric console per OpenShift project and Kubernetes namespace. If you plan to create multiple blockchain networks, for example to create different environments for development, staging, and production, you should create a unique project for each environment.
- You can only import nodes that have been exported from other IBM Support for Hyperledger Fabric consoles. In order to be able to operate an imported peer or ordering node from the console, you also need to import the associated node's organization MSP definition and administrator identity into your console.
- Mutual TLS is not supported between your applications and your blockchain nodes.
- You can not use the ESR version of Firefox to log in to the IBM Support for Hyperledger Fabric console.

## Documentation

For more information on IBM Support for Hyperledger Fabric 1.0.0, see [Getting started IBM Support for Hyperledger Fabric 1.0.0](https://cloud.ibm.com/docs/hlf-support?topic=hlf-support-get-started-console-ocp).

When you are ready to use the IBM Support for Hyperledger Fabric console to deploy and operate your blockchain network, see the [Build a network tutorial](https://cloud.ibm.com/docs/hlf-support?topic=hlf-support-ibm-hlfsupport-console-build-network).
