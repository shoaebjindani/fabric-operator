#*******************************************************************************
# IBM Confidential
# OCO Source Materials
# 5900-AM9
# (C) Copyright IBM Corp. 2020-2024 All Rights Reserved.
# The source code for this program is not  published or otherwise divested of
# its trade secrets, irrespective of what has been deposited with
# the U.S. Copyright Office.
#*******************************************************************************

IMAGE ?= us.icr.io/ibp-operator/support-operator
IMAGE_TEMP ?= us.icr.io/ibm-hlfsupport-temp/support-operator_debug

TAG ?= $(shell git rev-parse --short HEAD)
PRODUCT ?= support
IMAGE_TAG=$(GIT_TAG)
ARCH ?= $(shell go env GOARCH)
DOCKER_IMAGE_REPO ?= us.icr.io
REGISTRY ?= $(DOCKER_IMAGE_REPO)/ibp-golang
IBP_VER=1.0.0
GO_VER ?= 1.21.7
BUILD_DATE = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
OS = $(shell go env GOOS)

# oss operator source repo
GIT_REPO=https://github.com/hyperledger-labs/fabric-operator.git
# root dir name of GIT_REPO
export BUILD_DIR=fabric-operator

DOCKER_USER ?= token

BUILD_ARGS=--build-arg ARCH=$(ARCH)
BUILD_ARGS+=--build-arg REGISTRY=$(REGISTRY)
BUILD_ARGS+=--build-arg BUILD_ID=$(TAG)
BUILD_ARGS+=--build-arg BUILD_DATE=$(BUILD_DATE)
BUILD_ARGS+=--build-arg GO_VER=$(GO_VER)

ifneq ($(origin TRAVIS_PULL_REQUEST),undefined)
	ifneq ($(TRAVIS_PULL_REQUEST), false)
		TAG=pr-$(TRAVIS_PULL_REQUEST)
	endif
endif

NAMESPACE ?= n$(shell echo $(TAG) | tr -d "-")

.PHONY: build

build:## Builds the starter pack
	mkdir -p bin && go build -o bin/operator
	mkdir -p bin && go build -o bin/crd-install -pkgdir ./cmd/crd

image: generate login image-nologin

image-nologin: setup
	docker build --rm . -f Dockerfile $(BUILD_ARGS) -t $(IMAGE):$(IMAGE_TAG)-$(ARCH)
	docker tag $(IMAGE):$(IMAGE_TAG)-$(ARCH) $(IMAGE):latest-$(PRODUCT)-$(ARCH)

image-push-temp:
	docker tag $(IMAGE):$(IMAGE_TAG)-$(ARCH) $(IMAGE_TEMP):$(GIT_TAG)-$(PRODUCT)-$(ARCH)
	docker push $(IMAGE_TEMP):$(GIT_TAG)-$(PRODUCT)-$(ARCH)

govendor:
	@go mod vendor

image-push: login
	docker push $(IMAGE):$(IMAGE_TAG)-$(ARCH)

image-push-latest: login
	docker push $(IMAGE):latest-$(PRODUCT)-$(ARCH)

ibm-hlfsupport-temp-login: 
	echo $(DOCKER_TEMP_PASSWORD) | docker login -u $(DOCKER_USERNAME) --password-stdin us.icr.io/ibm-hlfsupport-temp


.PHONY: login
login:
	echo $(DOCKER_PASSWORD) | docker login -u $(DOCKER_USERNAME) --password-stdin $(DOCKER_IMAGE_REPO)

thirdparty-tools:
	@scripts/thirdparty-tools.sh

hsm-tests-ca:export OPERATOR_NAMESPACE=$(NAMESPACE)
hsm-tests-ca:
	@ginkgo -tags pkcs11 -failFast -timeout 30m -v  ./integration/hsm/ca

hsm-tests-peer:export OPERATOR_NAMESPACE=$(NAMESPACE)
hsm-tests-peer:
	@ginkgo -tags pkcs11 -failFast -timeout 30m -v  ./integration/hsm/peer

hsm-tests-orderer:export OPERATOR_NAMESPACE=$(NAMESPACE)
hsm-tests-orderer:
	@ginkgo -tags pkcs11 -failFast -timeout 30m -v  ./integration/hsm/orderer

int-ca-tests: export OPERATOR_IMAGE=$(IMAGE):$(TAG)-$(ARCH)
int-ca-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
int-ca-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/ca

int-peer-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
int-peer-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/peer

int-orderer-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
int-orderer-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/orderer

int-console-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
int-console-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/console

int-init-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
int-init-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/init

int-migration-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
int-migration-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/migration/...

e2ev2-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
e2ev2-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/e2ev2

ca-actions-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
ca-actions-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/actions/ca

orderer-actions-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
orderer-actions-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/actions/orderer

peer-actions-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
peer-actions-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/actions/peer

autorenew-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
autorenew-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/autorenew

cclauncher-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
cclauncher-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/cclauncher

restartmgr-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
restartmgr-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/restartmgr

operatorrestart-tests: export OPERATOR_NAMESPACE=$(NAMESPACE)
operatorrestart-tests:
	@ginkgo -failFast -timeout 30m -v  ./integration/operatorrestart

imports:
	@scripts/check-imports.sh

.PHONY: license
license:
	@scripts/check-license.sh

checks: license
	@scripts/checks.sh

unit-tests:generate
	@scripts/run-unit-tests.sh

gosec:
	@scripts/go-sec.sh

owasp-deps-check:
	@scripts/check-odc-results.sh

tests: unit-tests gosec

product-artifacts:
	@echo "product type = support"
	@cd internal; ./prepare-support.sh

setup:  govendor product-artifacts manifests bundle

#######################################
#### part of autogenerate makefile ####
#######################################

# Current Operator version
VERSION ?= $(IBP_VER)
# Default bundle image tag
BUNDLE_IMG ?= controller-bundle:$(VERSION)
# Options for 'bundle-build'
ifneq ($(origin CHANNELS), undefined)
BUNDLE_CHANNELS := --channels=$(CHANNELS)
endif
ifneq ($(origin DEFAULT_CHANNEL), undefined)
BUNDLE_DEFAULT_CHANNEL := --default-channel=$(DEFAULT_CHANNEL)
endif
BUNDLE_METADATA_OPTS ?= $(BUNDLE_CHANNELS) $(BUNDLE_DEFAULT_CHANNEL)

# Image URL to use all building/pushing image targets
IMG ?= controller:latest
# Produce CRDs that work back to Kubernetes 1.11 (no version conversion)
CRD_OPTIONS ?= "crd:crdVersions=v1"

# Get the currently used golang install path (in GOPATH/bin, unless GOBIN is set)
ifeq (,$(shell go env GOBIN))
GOBIN=$(shell go env GOPATH)/bin
else
GOBIN=$(shell go env GOBIN)
endif

all: manager

# Run tests
test: generate fmt vet manifests
	go test ./... -coverprofile cover.out

# Build manager binary
manager: generate fmt vet
	go build -o bin/manager main.go

# Run against the configured Kubernetes cluster in ~/.kube/config
run: generate fmt vet manifests
	go run ./main.go

# Install CRDs into a cluster
install: manifests kustomize
	$(KUSTOMIZE) build config/crd | kubectl apply -f -

# Uninstall CRDs from a cluster
uninstall: manifests kustomize
	$(KUSTOMIZE) build config/crd | kubectl delete -f -

# Deploy controller in the configured Kubernetes cluster in ~/.kube/config
deploy: manifests kustomize
	cd config/manager && $(KUSTOMIZE) edit set image controller=${IMG}
	$(KUSTOMIZE) build config/default | kubectl apply -f -

# Generate manifests e.g. CRD, RBAC etc.
manifests: controller-gen
	$(CONTROLLER_GEN) $(CRD_OPTIONS) rbac:roleName=manager-role webhook paths="./..." output:crd:artifacts:config=config/crd/bases

# Run go fmt against code
fmt:
	go fmt ./...

# Run go vet against code
vet:
	go vet ./...

# Generate code
generate: controller-gen
	$(CONTROLLER_GEN) object:headerFile="boilerplate/boilerplate.go.txt" paths="./..."

# Build the docker image
docker-build: test
	docker build . -t ${IMG}

# Push the docker image
docker-push:
	docker push ${IMG}

# find or download controller-gen
# download controller-gen if necessary
controller-gen:
ifeq (, $(shell which controller-gen))
	@{ \
	set -e ;\
	CONTROLLER_GEN_TMP_DIR=$$(mktemp -d) ;\
	cd $$CONTROLLER_GEN_TMP_DIR ;\
	go mod init tmp ;\
	go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.8.0 ;\
	rm -rf $$CONTROLLER_GEN_TMP_DIR ;\
	}
CONTROLLER_GEN=$(GOBIN)/controller-gen
else
CONTROLLER_GEN=$(shell which controller-gen)
endif

kustomize:
ifeq (, $(shell which kustomize))
	@{ \
	set -e ;\
	KUSTOMIZE_GEN_TMP_DIR=$$(mktemp -d) ;\
	cd $$KUSTOMIZE_GEN_TMP_DIR ;\
	go mod init tmp ;\
	go install sigs.k8s.io/kustomize/kustomize/v3@v3.5.4 ;\
	rm -rf $$KUSTOMIZE_GEN_TMP_DIR ;\
	}
KUSTOMIZE=$(GOBIN)/kustomize
else
KUSTOMIZE=$(shell which kustomize)
endif

# Generate bundle manifests and metadata, then validate generated files.
bundle: manifests
	operator-sdk generate kustomize manifests -q
	kustomize build config/manifests | operator-sdk generate bundle -q --overwrite --version $(VERSION) $(BUNDLE_METADATA_OPTS)
	operator-sdk bundle validate ./bundle

# Build the bundle image.
bundle-build:
	docker build -f bundle.Dockerfile -t $(BUNDLE_IMG) .

.PHONY: opm
OPM = ./bin/opm
opm:
ifeq (,$(wildcard $(OPM)))
ifeq (,$(shell which opm 2>/dev/null))
	@{ \
	set -e ;\
	mkdir -p $(dir $(OPM)) ;\
	curl -sSLo $(OPM) https://github.com/operator-framework/operator-registry/releases/download/v1.15.1/$(OS)-$(ARCH)-opm ;\
	chmod +x $(OPM) ;\
	}
else 
OPM = $(shell which opm)
endif
endif
BUNDLE_IMGS ?= $(BUNDLE_IMG) 
CATALOG_IMG ?= $(IMAGE_TAG_BASE)-catalog:v$(VERSION) ifneq ($(origin CATALOG_BASE_IMG), undefined) FROM_INDEX_OPT := --from-index $(CATALOG_BASE_IMG) endif 
.PHONY: catalog-build
catalog-build: opm
	$(OPM) index add --container-tool docker --mode semver --tag $(CATALOG_IMG) --bundles $(BUNDLE_IMGS) $(FROM_INDEX_OPT)

.PHONY: catalog-push
catalog-push: ## Push the catalog image.
	$(MAKE) docker-push IMG=$(CATALOG_IMG)